Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbUK3Twv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUK3Twv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUK3Twv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:52:51 -0500
Received: from ns1.braila.astral.Ro ([194.105.27.21]:41956 "EHLO
	LEU.braila.astral.ro") by vger.kernel.org with ESMTP
	id S262297AbUK3Tpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:45:55 -0500
Message-ID: <001101c4d715$25a59470$af00a8c0@BEBEL>
From: "Bebel" <bebel@braila.astral.ro>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: misleading error message
Date: Tue, 30 Nov 2004 21:45:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a BUG REPORT, as I see it, allthough more experienced Linux 
users might think differently:

I compiled built-in support for iptables in my new 2.6.9 kernel, but when my 
legacy firewall does a "modprobe ip_tables" , I get the startling message: 
"FATAL: module ip_tables not found" .
Please note that I am a Linux newbie and I think messages should help people 
solve problems, but this particular message made me re-compile the kernel 2 
more times ( stupid, huh ?) before I realized that iptables actually works, 
though the message had me thinking it wasn't :))
The message was probably caused by modprobe trying to load ip_tables module 
and not finding it, since support for it was built in the kernel (not as a 
module).
So I find this message quite misleading, firstly because the error was in no 
way "FATAL" (since iptables in fact WORKED) and secondly because it doesn't 
tell the user that iptables was already supported by the kernel.
A message like "Module ip_tables not needed; support already built in the 
kernel" would be much more helpfull, as I see it.

If it matters, I'm running Slackware 10.0 on a 500MHz Pentium 3 with 256MB 
RAM and a basic iptables firewall, on which I did a kernel upgrade from 
2.4.26 to 2.6.9 .
But this problem is common to many distros, as I could see on several 
forums.

Best regards,     Wussie . 

