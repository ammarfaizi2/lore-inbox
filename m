Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUL3QqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUL3QqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUL3QqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:46:00 -0500
Received: from rekin12.go2.pl ([193.17.41.32]:64432 "EHLO rekin12.go2.pl")
	by vger.kernel.org with ESMTP id S261661AbUL3Qps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:45:48 -0500
From: =?iso-8859-2?Q?Fryderyk_Mazurek?= <dedyk@go2.pl>
To: =?iso-8859-2?Q?Bill_Davidsen?= <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: =?iso-8859-2?Q?Re:_Problems_with_2.6.10?=
Date: Thu, 30 Dec 2004 17:45:46 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: o2.pl WebMail v5.27
X-Originator: 83.31.160.247
In-Reply-To: <41D3646A.9020806@tmr.com>
References: <1104201851.18175.39.camel@d845pe><20041227171159.51454193BFA@r10.go2.pl> <20041228145600.6A9FC193D36@r10.go2.pl> 
	<41D3646A.9020806@tmr.com>
Message-Id: <20041230164546.987845674D@rekin12.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm sorry, but acpi=routeirq doesn't work. But to my head came other
thing. I noticed that I on 2.6.9 (which correct works) I have this
part of dmesg:

hdb: Host Protected Area detected.
	current capacity is 66055248 sectors (33820 MB)
	native  capacity is 78165360 sectors (40020 MB)
hdb: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63,
UDMA(33)

and on 2.6.10 I have:

hdb: Host Protected Area detected.
	current capacity is 66055248 sectors (33820 MB)
	native  capacity is 78165360 sectors (40020 MB)
hdb: Host Protected Area disabled.
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(33)

How see, first is 32GB (33820 MB), and second is 40GB (40020MB).
Correct value should be 32GB, in spite that my disk is 40GB. I want
to say, that I have a little old BIOS and my BIOS detect only 32GB,
therefore I have limited size of my disk. And maybe kernel 2.6.10
influence on my BIOS and force to detect 40GB, which is not
operable, because my BIOS is too old. I think that maybe to fix it I
should force my kernel to detect only 32GB, how on kernel 2.6.9.
Maybe this is a BUG of new kernel?

Fryderyk.

---- Wiadomo¶æ Oryginalna ----
Od: Bill Davidsen <davidsen@tmr.com>
Do: Fryderyk Mazurek <dedyk@go2.pl>
Kopia do: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Data: Wed, 29 Dec 2004 21:14:02 -0500
Temat: Re: Problems with 2.6.10

> Fryderyk Mazurek wrote:
> > Hello.
> > 
> > My kernel 2.6.10 I compiled two times. First with ACPI and second
> > fully without ACPI. And the same situation.
> > For me this situation is strange, because usually reset should help,
> > but not this time. I thought that maybe my BIOS is too old. But with
> > 2.6.9 works. Therefore I don't know. Now I use 2.6.9.
> > 
> > Fryderyk.
> > 
> > ---- Wiadomo¶æ Oryginalna ----
> > Od: Len Brown <len.brown@intel.com>
> > Do: Fryderyk Mazurek <dedyk@go2.pl>
> > Kopia do: linux-kernel@vger.kernel.org
> > Data: 27 Dec 2004 21:44:11 -0500
> > Temat: Re: Problems with 2.6.10
> > 
> > 
> >>On Mon, 2004-12-27 at 12:11, Fryderyk Mazurek wrote:
> >>
> >>
> >>>problem starts when I do reboot. On boot screen my bios can't
detect
> >>>my disk. Bios stops and nothing.
> >>
> >>Does reboot work if the initial boot is with acpi=off?
> 
> With that system, perhaps acpi=ht would be better if he uses the
HT. And 
> pci=routeirq may help as well, although it told me it was disabling 
> IRQ18 and didn't!
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>    CTO TMR Associates, Inc
>    Doing interesting things with small computers since 1979
> 

