Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263309AbTCNIVU>; Fri, 14 Mar 2003 03:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbTCNIVT>; Fri, 14 Mar 2003 03:21:19 -0500
Received: from [202.109.126.231] ([202.109.126.231]:9661 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S263309AbTCNIVP>; Fri, 14 Mar 2003 03:21:15 -0500
Message-ID: <3E7192A2.CADEAE6D@mic.com.tw>
Date: Fri, 14 Mar 2003 16:28:18 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
References: <3E5CEF17.4C014A4C@mic.com.tw>
		 <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
		 <3E5EEDF9.5906D73E@mic.com.tw>  <3E64A8A5.4EBB5FB3@mic.com.tw>
		 <1046791639.10857.12.camel@irongate.swansea.linux.org.uk>
		 <3E683663.EBD184A4@mic.com.tw> <1047041925.20794.19.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 08:24:34.0531 (UTC) FILETIME=[24F01330:01C2EA03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Fri, 2003-03-07 at 06:04, rain.wang wrote:
> > > Once I understand what the problems all are yes. The BUG() is good, it
> > > confirms that what we are both seeing is the same thing - the reset is
> > > managing to issue two commands to the controller at the same time.
> >
> > Hi,
> >     thank you, Alan. I tested pre5-ac2 patch and that seems all ok.
>
> Thanks for the confirmation it is fixed

Hi Alan,
    for 2.4.21-pre5-ac2 and -ac3 patch also.
    there's still problem on reset. when I do 'hdparm -w /dev/hda' once
after another, all seems ok.  but when I make a shell script and let
'hdparm -w' run in several times loop, system would always crashed
at the second time and left oops messages:
    kernel BUG at ide.c:1700!
    ...
so, if any bugs still locking there?

rain.w


