Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSIDXUK>; Wed, 4 Sep 2002 19:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSIDXUK>; Wed, 4 Sep 2002 19:20:10 -0400
Received: from [62.72.117.40] ([62.72.117.40]:13069 "HELO mail.pi-group.net")
	by vger.kernel.org with SMTP id <S316213AbSIDXUI> convert rfc822-to-8bit;
	Wed, 4 Sep 2002 19:20:08 -0400
Message-ID: <03d501c2546a$183099a0$0575483e@webservice.be>
From: "Pascal Nobus" <pascal@nobus.be>
To: <linux-kernel@vger.kernel.org>
Subject: Rsync takes TCP down!
Date: Thu, 5 Sep 2002 01:23:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After changing the IP's of two machine the routing of one ethernet goes down.
(Destination host Unreachable)

HOST A                           HOST B
xxx.xxx.xxx.154   <--  hub   --> xxx.xxx.xxx.148
192.168.100.154   <-- switch --> 192.168.100.148

on host A:
rsync -e ssh backup@xxx.xxx.xxx.148 (files) OK no prob

ssh 192.168.100.148 (OK no prob, I can login and do everything)
rsync -e ssh backup@192.168.100.148 (files) Problem.

On the last command I get a respons from the ethernet-card of host A that the network cannot be reached.
It still possible to ping to that ethernet-card (so the card is not down), if I look in the routing (route -C) I see no problem.
Because all the other connections seems fine, I have no idea where to look.
(allready changed all the network-cards, cables, the switch and the hub)

Best regards,
Pascal
 



