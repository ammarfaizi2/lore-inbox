Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTGWOxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbTGWOxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:53:31 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3848 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270375AbTGWOx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:53:29 -0400
Subject: Re: root= needs hex in 2.6.0-test1-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Felker <tcfelker@mtco.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030723144351.A3367@infradead.org>
References: <200307230156.40762.tcfelker@mtco.com>
	 <20030723144351.A3367@infradead.org>
Content-Type: text/plain
Message-Id: <1058972911.718.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 17:08:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-23 at 15:43, Christoph Hellwig wrote:
> On Wed, Jul 23, 2003 at 01:56:40AM -0500, Tom Felker wrote:
> > I finally booted 2.6.0-test1-mm2, after reading somebody else who needed to 
> > use hex in the root= argument.  root=/dev/hdb1 and root=hdb2 would panic 
> > ("VFS: Cannot open root device hdb1 or unknown-block(0,0)"), but root=0341 
> > worked.  Devfs is compiled in, devfs=nomount and devfs=mount make no 
> > difference.  Is this intentional?
> 
> Yes.  If you use devfs you have to use devfs names for root=.  It's
> pretty simple.  Best option of course is to avoid devfs.

I didn't compile devfs in... However, root=/dev/xxx caused a panic
during bootup. So, I guess those panics aren't related exclusively to
devfs.

What's really strange on this issue is that I haven't still heard any
response from the kernel gurus :-?

