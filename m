Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275406AbTHIVOV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275407AbTHIVOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:14:21 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:45696 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S275406AbTHIVOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:14:19 -0400
Date: Sat, 9 Aug 2003 23:14:16 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.name
Subject: Re: Linux 2.6.0-test3
Message-ID: <20030809211416.GA2105@finwe.eu.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net, oliver@neukum.name
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

[...]

> Oliver Neukum:
>   o USB: error return codes in usblp
>   o USB: cleanup of usblp (release and poll)
>   o USB: fix race condition in usblp_write

[...]

Well, I cannot finish printing anything now and I believe, that one of
above is responsible. 
It looks as if printer gets some amount of data but then communication 
'stops' and printer waits for more data (usually I have about 2cm 
of page printed, paper locked and later printer error leds start
blinking happily :)

Not sure, if it's directly related, but system seems to be less 
responsive later.

Version of usblp.c from 2.6.0-test2 compiled with 2.6.0-test3 does
not work as I expected (I can load module, but printer is not 
detected - no usual 'usblp0: USB Unidirectional printer dev 3 if 0 alt 1
proto 2 vid 0x03F0 pid' message in logs).

I traced my problem down to -test2-bk2 (with bk1 everything works
correctly).

o Printer is connected to /dev/usb/lp0; it's HP840c
o ver_linux output: http://zeus.polsl.gliwice.pl/kernel/2.6.0-test3/ver_linux
o config: http://zeus.polsl.gliwice.pl/kernel/2.6.0-test3/config
o dmesg: http://zeus.polsl.gliwice.pl/kernel/2.6.0-test3/dmesg
o /proc/bus/usb/devices: http://zeus.polsl.gliwice.pl/kernel/2.6.0-test3/devices
o some related logs: http://zeus.polsl.gliwice.pl/kernel/2.6.0-test3/logs

Any suggestions are welcome :)

jk

-- 
Jacek Kawa
