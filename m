Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272341AbRIPPIA>; Sun, 16 Sep 2001 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272345AbRIPPHu>; Sun, 16 Sep 2001 11:07:50 -0400
Received: from mail1.rrz.Uni-Koeln.DE ([134.95.100.208]:27281 "EHLO
	mail1.rrz.Uni-Koeln.DE") by vger.kernel.org with ESMTP
	id <S272341AbRIPPHo>; Sun, 16 Sep 2001 11:07:44 -0400
Date: Sun, 16 Sep 2001 17:08:05 +0200 (MET DST)
From: Jens Ruehmkorf <J.Ruehmkorf@Uni-Koeln.DE>
Reply-To: Jens Ruehmkorf <J.Ruehmkorf@Uni-Koeln.DE>
To: linux-kernel@vger.kernel.org
Subject: Root-NFS Problems and portmap
Message-ID: <Pine.SOL.3.96.1010916153453.327A-100000@campfire.rrz.Uni-Koeln.DE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have some problems getting Root-NFS to work properly. 

On the server side is a linux 2.4.9 with tcp-wrapper (release 7.6) and
portmapper (release 5) in use on a Debian GNU/Linux 3.0 box.

When using Root-NFS with linux-2.4.5 or later, I get the following
messages repeatedly: 

-- snip --
Looking up port of RPC 100003/2 on <server-ip>
RPC: sendmesg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
-- snap --

In particular I tried 2.4.5, 2.4.8 and 2.4.9 on this with the same errors. 
I passed various nfsroot-options to the kernel (including nolock) with no
success. 

Surprisingly, when using 2.4.4 (or 2.2.19 which has dhcp-ipconfig as well) 
everything works just fine. I used the working config-2.4.4-nfsroot to
compile one of the more recent kernels (which fails).

Starting with 2.4.5 net/ipv4/ipconfig.c has changed to add support of
dhcp, so maybe it has something to do with this? According to tcpdump,
IP-Config itself works alright though.

If you need any more information such as kernel-config, send me an email.

PLEASE: If anybody has a working 2.4.x nfsroot-kernel with x > 4, please
send me your config so I can find the problem.

Kind regards,
Jens Ruehmkorf

--
j dot ruehmkorf at uni hyphen koeln dot de


