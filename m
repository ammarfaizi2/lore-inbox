Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUF2WUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUF2WUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUF2WUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:20:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266116AbUF2WT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:19:58 -0400
Date: Tue, 29 Jun 2004 23:19:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk copy, last sector problem
Message-ID: <20040629221957.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <600B91D5E4B8D211A58C00902724252C01BC071A@piramida.hermes.si> <cbspbv$f56$2@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbspbv$f56$2@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 06:16:25PM -0400, Bill Davidsen wrote:
> >So the copy will still miss the last sector ?
> >But the blockdev command is a working workaround ?
> >Are there any downsides of setting the block size to
> >512 bytes right at boot for all hard drives ?
> >What about 8kb sectors, do they work ?
> 
> Given that the change from 1k to 4k, I suspect that going to 512 will 
> suck rocks off the bottom of the ocean in terms of performance. I don't 
> think that 8k works in 2.4, it didn't work in my 2.6, but the error was 
> "device busy" so it may not be related to anything but having no spare 
> drive.

First of all, it *will* work without any "blockdev command" crap.
And no, performace is not a problem - we get requests immediately
merged and unlike regular files we don't spend time figuring out
where the hell next block is.
