Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288667AbSA2H2S>; Tue, 29 Jan 2002 02:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSA2H2H>; Tue, 29 Jan 2002 02:28:07 -0500
Received: from goliath.siemens.de ([194.138.37.131]:40592 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S288667AbSA2H1z>; Tue, 29 Jan 2002 02:27:55 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
Date: Tue, 29 Jan 2002 10:27:23 +0300
Message-ID: <000001c1a896$64e5ff40$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I changed "none" to "devfs" in do_mount("none", "/dev", "devfs", 0,
""): 
> "none is busy" is misleading at umount time :-) 

File systems that do not have real devices behind them have "none" as
device. Please do not change it - it was correct. Having it later in
/proc/mounts may confuse some user-level tools. If you want to fix it -
fix umount to report something more sensible if device == none.

-andrej


