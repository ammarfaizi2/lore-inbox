Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbULZF13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbULZF13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 00:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbULZF13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 00:27:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:6276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261617AbULZF10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 00:27:26 -0500
Date: Sat, 25 Dec 2004 21:27:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Blazejowski <diffie@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, Diffie <diffie@blazebox.homeip.net>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Ho ho ho - Linux v2.6.10
In-Reply-To: <9dda349204122520106f3b2f46@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412252121370.2353@ppc970.osdl.org>
References: <9dda349204122520106f3b2f46@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Dec 2004, Paul Blazejowski wrote:
>
> Ho ho ho, my NFS is no go!
> 
> NFS needs some symbols here  and SCSI prints DV failed to configure device.

That sounds like a configuration error, or not running depmod/modprobe 
properly. svc_wake_up() &co are exported by the sunrpc module, and you've 
apparently not loaded it..

As to what the "DV failed", it's apparently normal if DV is disabled, 
whatever the hell that is.  James will know whether it's something to 
worry about..

		Linus
