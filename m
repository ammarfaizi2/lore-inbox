Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbRGNWAo>; Sat, 14 Jul 2001 18:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264933AbRGNWAe>; Sat, 14 Jul 2001 18:00:34 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:55217 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264927AbRGNWAW>; Sat, 14 Jul 2001 18:00:22 -0400
Date: Sat, 14 Jul 2001 17:00:21 -0500
From: J Troy Piper <jtp@dok.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>, rusty@rustcorp.com.au
Subject: [Problem] Linux 2.4.5-ac17 ipt_unclean 'fixes'
Message-ID: <20010714170021.B1391@dok.org>
Mime-Version: 1.0
Content-Type: message/rfc822
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.4.5-ac17
> o	First set of ipt_unclean fixes			(Rusty Russell)

Alan, 

I apologise for having taken so long to write this (I have known about 
this problem since 2.4.5ac17 and have not had a chance to document til 
today) but there seems to be a problem with the ipt_unclean fixes by Rusty 
Russell.  ANY incoming packets from any interface (ppp0 and eth0) are 
marked as 'unclean' with some variation on the following syslog entry:

Jul  8 23:16:04 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
Jul  8 23:16:05 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
Jul  8 23:16:16 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
Jul  8 23:16:18 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long

and thus are blocked by my 'unclean packet dropping' firewall (iptables).

I haven't seen any mention of this on the list, nor have I seen any more 
ipt_unclean patches to address this problem, so here's your heads-up 
(albeit a bit late).

Thanks,

J Troy Piper
jtp@dok.org
