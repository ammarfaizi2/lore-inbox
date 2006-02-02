Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWBBPOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWBBPOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWBBPOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:14:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29971 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751116AbWBBPOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:14:36 -0500
Date: Thu, 2 Feb 2006 15:14:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202151424.GB8944@ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602022228.20032.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Any technical reasons why suspend modules shouldn't be in userspace? I
> > can understand that you're not keen on redoing them but that's not an
> > argument for inclusion in the mainline.
> 
> They're using cryptoapi to do the compression and encryption, and bio to do 
> the I/O. Moving this to userspace will add extra complexity and of course 

You are mostly using LZW, not supported by cryptoapi, anyway.

> slow down the process.

Slowdown will not be measurable, syscalls are cheap.

> Shouldn't the question be "Why are we making this more complicated by moving 
> it to userspace?"

Because thats how the kernel works. We do not put random stuff into
kernel because someone happened to code it for kernelspace first. It
helps us with long-term sanity.
								Pavel
-- 
Thanks, Sharp!
