Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUCBCMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 21:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUCBCMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 21:12:07 -0500
Received: from bay14-dav4.bay14.hotmail.com ([64.4.48.108]:14610 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261541AbUCBCMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 21:12:01 -0500
X-Originating-IP: [152.3.119.245]
X-Originating-Email: [filamoon2@hotmail.com]
From: "Charlie \(Zhanglei\) Wang" <filamoon2@hotmail.com>
To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
References: <BAY14-F68kiyPoHZgzD000006ad@hotmail.com> <200402282255.18609.vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: udp packet loss even with large socket buffer
Date: Mon, 1 Mar 2004 21:12:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY14-DAV4PA2sRlnbM000155ac@hotmail.com>
X-OriginalArrivalTime: 02 Mar 2004 02:12:00.0456 (UTC) FILETIME=[BF1A6C80:01C3FFFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Thanks for your reply. If you want to exactly reproduce my problem, please
use the following
commands to download my codes from cvs:

cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/gaim-vv login
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/gaim-vv co
linphone

Simply hit enter when prompted for passwd.
(1) Please download and install libosip before compiling.
(2) Before ./configure, please run command 'rm -Rf ffmpeg; ln -s
ffmpeg-0.4.8 ffmpeg'.
(3) After 'make' and 'make install', use 'linphonec' to run the program.
(4) Under linphonec, use the following commands to communicate with windows
messenger:
   r www-db.research.bell-labs.com
   c <sip:username_of_windows_messenger@www-db.research.bell-labs.com>

www-db.research.bell-labs.com is a public sip server.

Under Windows Messenger (which runs only under WinXP), use SIP login
method. Sign-in name should be
username_of_windows_messenger@www-db.research.bell-labs.com

Please note that Windows Messenger is different from MSN Messenger.

I know it's kind of complicated... :( Thank you in advance!
PS: My Linux box and Windows XP box run in the same LAN.

Johnny

----- Original Message ----- 
From: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
To: "johnny zhao" <filamoon2@hotmail.com>; <linux-kernel@vger.kernel.org>
Sent: Saturday, February 28, 2004 4:22 PM
Subject: Re: udp packet loss even with large socket buffer


> On Saturday 28 February 2004 03:09, johnny zhao wrote:
> > Hi,
> >
> > I have a problem when trying to receive udp packets containing video
data
> > sent by Microsoft Windows Messenger. Here is a detailed description:
> >
> > Linux box:
> >     Linux-2.4.21-0.13mdksmp, P4 2.6G HT
> > socket mode:
> >     blocked mode
> > code used:
> >     while ( recvfrom(...) )
> > socket buffer size:
> >     8388608, set by using sysctl -w net.core.rmem_default and rmem_max
> >
> > I used ethereal(using libpcap) to monitor the network traffic. All the
> > packets were transferred and captured by libpcap. But my program
constantly
> > suffers from packet loss. According to ethereal, the average time
interval
> > between 2 packets  is 70-80ms, and the minimum interval can go down to
> > ~1ms. Each packet is smaller than 1500 bytes (ethernet MTU).
> >
> > Can anybody help me? I googled and found a similar case that had been
> > solved by increasing the socket buffer size. But it doesn't work for me.
I
> > think 8M is a crazily large size :(
>
> Post a small program demonstrating your problem.
> (I'd test udp receive with netcat too)
> --
> vda
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
