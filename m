Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264944AbUELGaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbUELGaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbUELGaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:30:09 -0400
Received: from agp.Stanford.EDU ([171.67.73.10]:7595 "EHLO agp.stanford.edu")
	by vger.kernel.org with ESMTP id S264944AbUELGaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:30:05 -0400
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200405120621.i4C6LmEE018369@csl.stanford.edu>
Subject: Re: [MC] Re: [CHECKER] e2fsck writes out blocks out of order,
To: root@chaos.analogic.com
Date: Tue, 11 May 2004 23:21:48 -0700 (PDT)
Cc: yjf@stanford.edu (Junfeng Yang), ext2-devel@lists.sourceforge.net,
       mc@cs.stanford.edu, dill@cs.stanford.edu (David L. Dill),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
       madan@cs.stanford.edu
Reply-To: engler@csl.stanford.edu
In-Reply-To: <Pine.LNX.4.53.0405112238140.3269@chaos> from "Richard B. Johnson" at May 11, 2004 10:45:33 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scan-Signature: f00e262f4027f569778983ab38d6ce67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 11 May 2004, Junfeng Yang wrote:
> 
> > Hi,
> >
> > We got a warning that the filesystem was in a inconsistent state when:
> > 1. created a crashed disk image
> > 2. ran fsck over the image and then crash fsck at certain point
> > 3. re-ran fsck.
> 
> Question?  Is fsck specified to be able to be crashed? I'm not
> sure you could ever make a repair-tool that could do that unless
> there was some "guaranteed to save device" on an independent power
> source during the repair. Fsck can't commit partial fixes of some
> stuff because it would leave the file-system in an unrecoverable
> state. It needs to complete.

To the extent that it is simply replaying records in a journal, it should
be able to crash at arbitrary points before commit and then restart
without fuss.  That's one of the motivations for using logging in a file
system ;-)
