Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSAXM7g>; Thu, 24 Jan 2002 07:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285482AbSAXM71>; Thu, 24 Jan 2002 07:59:27 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:15204 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287764AbSAXM7R>; Thu, 24 Jan 2002 07:59:17 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 13:59:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de> <E16TZhr-00049f-00@mxng04.kundenserver.de>
In-Reply-To: <E16TZhr-00049f-00@mxng04.kundenserver.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020124125914.0B3ED13D1@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 03:33, Dieter Nützel wrote:
> On Wednesday, 23. January 2002 21:16, Hans-Peter Jansen wrote:
> [-]
>
> > BTW: Would some enlighted kernel brain explain, why
> >     [ ]     RTC stores time in GMT
> > is only available, when APM is enabled. Does this mean, I cannot
> > define my RTC mode when using ACPI?
>
> Hans-Peter,
> as you have ACPI running already, you should have noticed that "your" clock
> (RTC) is in GMT time without a separate switch.
>
> Mine is (compare with send time):
>
> /home/nuetzel> cat /proc/driver/rtc
> rtc_time        : 02:33:14
> rtc_date        : 2002-01-24
> rtc_epoch       : 1900
> alarm           : 00:00:00
> DST_enable      : no
> BCD             : yes
> 24hr            : yes
> square_wave     : no
> alarm_IRQ       : no
> update_IRQ      : no
> periodic_IRQ    : no
> periodic_freq   : 1024
> batt_status     : okay

Hi Dieter,

it took you 22 sec. to finish and send your mail. Pretty quick :)

My RTC seems totally bogus:

elfe:~# date; clock; cat /proc/driver/rtc 
Thu Jan 24 13:42:03 CET 2002
Thu Jan 24 19:12:04 2002  -0.144010 seconds
rtc_time        : 18:12:04
rtc_date        : 2002-01-24
rtc_epoch       : 1900
alarm           : 09:30:15
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay

I thought, ntpd would take care of the RTC:

Jan 23 23:38:02 elfe xntpd[356]: ntpd 4.1.0 Fri Sep 21 14:42:26 GMT 2001 (1)
Jan 23 23:38:02 elfe xntpd[356]: signal_no_reset: signal 13 had flags 4000000
Jan 23 23:38:02 elfe xntpd[356]: precision = 9 usec
Jan 23 23:38:02 elfe xntpd[356]: kernel time discipline status 0040
Jan 23 23:38:02 elfe xntpd[356]: frequency initialized 58.785 from 
/etc/ntp.drift

Obviously it doesn't. 

I will take a look in the SuSE /etc/init.d scripts for this...

> Regards,
> 	Dieter

Cheers,
  Hans-Peter
