Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUGHFdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUGHFdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGHFdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:33:02 -0400
Received: from tag.witbe.net ([81.88.96.48]:45696 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265792AbUGHFc6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:32:58 -0400
Message-Id: <200407080532.i685WpX28901@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <rol@as2917.net>, "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Init single and Serial console : How to ?
Date: Thu, 8 Jul 2004 07:32:45 +0200
Organization: AS2917.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <200407041032.i64AWTX21222@tag.witbe.net>
Thread-Index: AcRhrwtNtyy11t7TSGSGoKSx/siFGQAAjYOQAL7e+VA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Got this one working :

LILO: linux init=/sbin/sulogin /dev/ttyS0

It finally asked me to enter root password, I did my maintenance, 
and then...
/sbin/reboot did nothing
leaving the shell (exit) said :
Attempting to kill init
Panic, will reboot in 30 seconds.
(or something like that), but it didn't restart, and I had to reboot
the machine...
Is this the expected behaviour ?

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de Paul Rolland
> Envoyé : dimanche 4 juillet 2004 12:32
> À : 'Bernd Eckenfels'; linux-kernel@vger.kernel.org
> Objet : Re: Init single and Serial console : How to ?
> 
> Hello,
> 
> > this is only about terminal settings like flags  and line 
> > speed, it is not
> > related to presenting the login on the serial console. It is 
> > a good idea to
> > remove this file and set the baud rate on the boot command line.
> OK.
>  
> > You must configure /sbin/sulogin which is called from init to run on
> > /dev/console, then you will be fine. Also you should start 
> a getty on
> OK, but remember that my problem is to find a way to access 
> the machine
> when I only have a serial console and it doesn't complete the 
> "classical"
> boot process because some init script at runlevel 3 is blocking...
> 
> This means that I can't go up to the "configure 
> /sbin/sulogin", and need
> a way to be given a serial prompt only by giving parameter at the LILO
> prompt, considering that the kernel has already been 
> configured for serial
> console.
> 
> > /dev/ttySx for multi user modes (see the serial console howto)
> This is already done.
> 
> Regards,
> Paul
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

