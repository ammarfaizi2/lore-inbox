Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbULFRGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbULFRGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbULFRGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:06:50 -0500
Received: from main.gmane.org ([80.91.229.2]:28050 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261565AbULFRGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:06:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Date: Mon, 06 Dec 2004 12:06:46 -0500
Message-ID: <87mzwrpd95.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com> <20041206162153.GH16958@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:lEoqGGmZB/0jiLaKNXRUxcCV5ek=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Mon, 2004-12-06 10:51:46 -0500, Ed L Cashin <ecashin@coraid.com>
...
>> Like IP, AoE is an ethernet-level network protocol, registered with
>> the IEEE.  Unlike IP, AoE is not routable.
>
> So AoE is out of scope for many uses...

The usual way of using it is to use an ethernet switch and then put
all your AoE storage on that LAN.

You could probably get creative with tunnelling or something, but it's
easier to just configure a LAN.  If you really need storage over the
internet, you'd probably use something else like iSCSI.

...
[helpful style comments, thanks]

...
> After all, especially keeping in mind that AoE isn't routeable, my
> thinking is that this had better written as a (E)NBD server process
> running in userspace. This way, you'd use the in-kernel NBD driver (or
> the ENBD which isn't in the kernel) and you the the routing stuff for
> free :)

We looked at the NBD stuff, but it's a different model, and it goes
over TCP/IP, if I recall correctly.  ATA over Ethernet is a simpler,
lower-level protocol, saving the host the work of doing TCP/IP.

-- 
  Ed L Cashin <ecashin@coraid.com>

