Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbTLRAsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTLRAsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:48:15 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27841 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264883AbTLRAsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:48:14 -0500
Date: Thu, 18 Dec 2003 01:45:37 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
Message-ID: <20031218014537.A8113@electric-eye.fr.zoreil.com>
References: <20031213140106.A24017@electric-eye.fr.zoreil.com> <200312131440.28071.Marcus.Blomenkamp@epost.de> <20031214144055.A4664@electric-eye.fr.zoreil.com> <200312151124.15143.Marcus.Blomenkamp@epost.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200312151124.15143.Marcus.Blomenkamp@epost.de>; from Marcus.Blomenkamp@epost.de on Mon, Dec 15, 2003 at 11:24:15AM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Blomenkamp <Marcus.Blomenkamp@epost.de> :
[...]
> I tcpdump'ed both sides on transferring 1 Megabyte to the 8139 based machine 
> for both low level transfers (UDP, TCP) and on filesystem level (NFS).
> 
> NFS: dd 1M to remote file
> UDP/TCP: dd 1M trough netcat
> TCP: scp 1M file
> 
> Very interestingly i could not reproduce the NFS lockup during this double 
> monitoring setup. So i ran it twice - once for each machine in promiscious 
> mode. And guess: If the 8169 NIC is in monitoring mode, NFS writes do not 
> lock up. I can even recover the machine from stalling by explicitly entering 
> promiscious mode and SIGINT'ing the writing process.

The dumps show that the server misses frames and/or sees generous amount
of garbage during UDP transfer. Which transfer rate can you achieve for big
writes between 8129 ?

Can you:
- retrieve the ifconfig output on the client/server just before and after the
  write (8192 sized NFS from 8169 to 8139) ?
- send a dump of a 8192 bytes sized 1Mo write from 8139 to 8139 ?

--
Ueimor
