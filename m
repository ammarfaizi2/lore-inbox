Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132743AbRC2PSw>; Thu, 29 Mar 2001 10:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132755AbRC2PSf>; Thu, 29 Mar 2001 10:18:35 -0500
Received: from [32.97.166.34] ([32.97.166.34]:23037 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S132743AbRC2PSJ>;
	Thu, 29 Mar 2001 10:18:09 -0500
Message-Id: <m14gkPG-001PKeC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: max ip_conntrack entries 
In-Reply-To: Your message of "Wed, 21 Mar 2001 19:34:47 -0000."
             <20010321193447.A555@grobbebol.xs4all.nl> 
Date: Sat, 24 Mar 2001 20:32:22 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010321193447.A555@grobbebol.xs4all.nl> you write:
> 
> is there a way to dynamically change the limit : kernel: ip_conntrack:
> maximum limit of 16384 entries exceeded ?

echo 32768 > /proc/net/ipv4/ip_conntrack_max

Don't increase it too much, or your efficiency will go out the window
(the hash table size doesn't increase).

> either a newssus scan or a weird ftp server I tried to connect to,
> caused the table to fill pretty fast and all other connections stopped
> for a short time.

It will start dropping "unreplied" connections.

Rusty.
--
Premature optmztion is rt of all evl. --DK
