Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266381AbUGJUOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUGJUOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUGJUOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:14:40 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:5110 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266381AbUGJUO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:14:26 -0400
Message-ID: <099101c466ba$7d75aa30$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>
Cc: "Tim Bird" <tim.bird@am.sony.com>,
       "CE Linux Developers List" <celinux-dev@tree.celinuxforum.org>,
       "Todd Poynor" <tpoynor@mvista.com>,
       "Geert Uytterhoeven" <geert@linux-m68k.org>
References: <40EEF10F.1030404@am.sony.com> <20040710115413.A31260@mail.kroptech.com> <20040710142800.A5093@mail.kroptech.com> <200407101319.31147.dtor_core@ameritech.net>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Date: Sat, 10 Jul 2004 16:14:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Saturday 10 July 2004 01:28 pm, Adam Kropelin wrote:
>> + Note that on SMP systems the preset will be applied to all CPUs
>> + which will cause problems if for some reason your CPUs need
>> + significantly divergent settings.
>> +
>> + If unsure, set this to 0. An incorrect value will cause delays in
>> + the kernel to be wrong, leading to unpredictable I/O errors and
>> + other breakage. Although unlikely, in the extreme case this might
>> + damage your hardware.
>
> Note that it may also not work correctly on laptops that switch
> frequency when working on battery/AC. Also one needs to be careful
> when changing timesource (pit, tsc, pm, hpet). And always look out
> for timer code changes in next version of kernel.

Certainly many demons lurk around the corner, but embedded guys are used to
that.

> Does 250 ms worth all this pain?

On a desktop box, almost certainly not. On a massive SMP machine, maybe. On
an embedded system that is required to boot in a ridiculously short time,
absolutely.

--Adam

