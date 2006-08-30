Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWH3XDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWH3XDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWH3XDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:03:16 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:5076 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1751605AbWH3XDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:03:16 -0400
Date: Thu, 31 Aug 2006 00:03:14 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [FOR 2.6.18 FIX][PATCH]  drm: radeon flush TCL VAP for vertex
 program enable/disable
In-Reply-To: <Pine.LNX.4.64.0608301550090.27779@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0608302357250.21600@skynet.skynet.ie>
References: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
 <20060830154152.9ac71753.akpm@osdl.org> <Pine.LNX.4.64.0608301550090.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> It looks ok to me, although you have to look into the caller to see why it
> does what it does.
>
> It would be "prettier" if it changed the size and data of the incoming
> packet instead, but the code as is isn't actually set up to be able to do
> that (the size setup and verification stuff is done before the fixup).
>
> That said, I'd have expected that the VAP state flush is really something
> that the _client_ should do when it generates the commands, not the kernel
> after the fact. Although maybe the kernel could keep track of whether the
> flush is needed at all, and since we apparently allow untrusted generation
> of packets, maybe this is the right approach..

The problem is of course if the userspace side does it, the lockup is 
simple to trigger, we'd like if we can to stop them triggering it, we 
don't stop every lockup, but it would be nice to stop the ones we can...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

