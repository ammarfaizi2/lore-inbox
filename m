Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUDLKBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUDLKBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:01:15 -0400
Received: from imap.gmx.net ([213.165.64.20]:26587 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262772AbUDLKBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:01:12 -0400
X-Authenticated: #11437207
Date: Mon, 12 Apr 2004 13:02:36 +0200
From: Tim Blechmann <TimBlechmann@gmx.net>
To: "Ivica Ico Bukvic" <ico@fuse.net>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: <daniel.ritz@gmx.ch>, "'Thomas Charbonnel'" <thomas@undata.org>,
       <ccheney@debian.org>, <linux-pcmcia@lists.infradead.org>,
       <linux-kernel@vger.kernel.org>, <alsa-devel@lists.sourceforge.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
 -- FIXED!
Message-Id: <20040412130236.66a86b50@laptop>
In-Reply-To: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
References: <200404120145.22679.daniel.ritz@gmx.ch>
	<20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ico, hi russell

first of all, congratulations that you, ico, got your hdsp working ...
anyway the registers you were changing have no effect on my setup ... they are zero:

your configuration:
> [root@localhost 00]# hexdump 
> -v /proc/bus/pci/00/0a.0 
> 0000000 1524 1410 0007 0210 0000 0607 a808 0002 
> 0000010 f000 ffe7 00a0 0200 0200 b005 e000 ffe7 
> 0000020 e000 ffe7 0000 2000 f000 203f 5000 0000 
> 0000030 50fc 0000 5400 0000 54fc 0000 010b 05c0 
> 0000040 161f 2032 0001 0000 0000 0000 0000 0000 
> 0000050 0000 0000 0000 0000 0000 0000 0000 0000 
> 0000060 0000 0000 0000 0000 0000 0000 0000 0000 
> 0000070 0000 0000 0000 0000 0000 0000 0000 0000 
> 0000080 9021 4044 0000 0000 0000 0000 1002 0100 
> 0000090 82c0 6044 0000 0000 0000 0000 0000 0000 
> 00000a0 0001 fe01 0000 00c0 0000 0000 001f 0000 
> 00000b0 0000 0000 0000 0000 0000 0000 0000 0000 
> 00000c0 1000 0000 0080 0080 0600 1008 0000 0000 
> 00000d0 0000 0000 0000 0000 0000 0000 0000 0000 
> 00000e0 0000 0000 0000 0000 0000 0000 0000 0000 
> 00000f0 0000 0000 0000 0000 0000 0000 0000 0000 
> 0000100 

mine: (kernel 2.6.4-ck1 and 2.6.5-gentoo have the same results)
bash-2.05b# hexdump -v /proc/bus/pci/02/00.1
0000000 1217 6933 0087 0410 0001 0607 a800 0082
0000010 1000 2000 00a0 0200 0702 b00a 0000 20c0
0000020 f000 20ff 0000 2100 f000 213f 4c01 0000
0000030 4cfd 0000 5001 0000 50fd 0000 0200 0580
0000040 1025 0019 0001 0000 0000 0000 0000 0000
0000050 0000 0000 0000 0000 0000 0000 0000 0000
0000060 0000 0000 0000 0000 0000 0000 0000 0000
0000070 0000 0000 0000 0000 0000 0000 0000 0000
0000080 0000 0000 0000 0000 0000 0000 0000 0000
0000090 23bf 4c00 03e8 8242 0000 2050 0000 0000
00000a0 0001 fe02 4000 00c0 0000 0000 0000 0000
00000b0 0000 0000 0000 0000 0000 0000 0000 0000
00000c0 0000 0000 0000 0000 0000 0000 0000 0000
00000d0 0000 0000 0000 0000 0000 0000 0000 0000
00000e0 0000 0000 0000 0000 0000 0000 0000 0000
00000f0 0000 0000 0000 0000 0000 0000 0000 0000
0000100

after plugging the hdsp in:
> bash-2.05b# hexdump -v /proc/bus/pci/02/00.1
> 0000000 1217 6933 0087 0410 0001 0607 a800 0082
> 0000010 1000 2000 00a0 0200 0702 b00a 0000 20c0
> 0000020 f000 20ff 0000 2100 f000 213f 4c01 0000
> 0000030 4cfd 0000 5001 0000 50fd 0000 0200 0500
> 0000040 1025 0019 0001 0000 0000 0000 0000 0000
> 0000050 0000 0000 0000 0000 0000 0000 0000 0000
> 0000060 0000 0000 0000 0000 0000 0000 0000 0000
> 0000070 0000 0000 0000 0000 0000 0000 0000 0000
> 0000080 0000 0000 0000 0000 0000 0000 0000 0000
> 0000090 23bf 4c00 03e8 8242 0000 2050 0000 0000
> 00000a0 0001 fe02 4000 00c0 0000 0000 0000 0000
> 00000b0 0000 0000 0000 0000 0000 0000 0000 0000
> 00000c0 0000 0000 0000 0000 0000 0000 0000 0000
> 00000d0 0000 0000 0000 0000 0000 0000 0000 0000
> 00000e0 0000 0000 0000 0000 0000 0000 0000 0000
> 00000f0 0000 0000 0000 0000 0000 0000 0000 0000
> 0000100

the only register that's changing after plugging the hdsp in is the MIN_GNT register ... (from 0x80 to 0x00)
the registers ico changed are 00 on my system ... possibly i'll have to install windows on my machine to figure out, if i have the same problem as ico ... 

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

