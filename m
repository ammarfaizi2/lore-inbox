Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUELDUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUELDUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUELDUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:20:20 -0400
Received: from thunk.org ([140.239.227.29]:40358 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264958AbUELDUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:20:16 -0400
Date: Tue, 11 May 2004 23:19:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
       madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: Re: [CHECKER] e2fsck writes out blocks out of order, causing root dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
Message-ID: <20040512031936.GB4245@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
	madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
References: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU> <Pine.LNX.4.53.0405112238140.3269@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0405112238140.3269@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 10:45:33PM -0400, Richard B. Johnson wrote:
> On Tue, 11 May 2004, Junfeng Yang wrote:
> 
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

There will always be some repairs that e2fsck will need to do that
can't be crash safe, but that doesn't mean that we shouldn't strive to
make it as crash-proof as possible.  Especially when the fix is
relatively simple.....

						- Ted
