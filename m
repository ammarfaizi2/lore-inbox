Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCOMxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCOMxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVCOMxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:53:15 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:9756 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261200AbVCOMxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:53:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UnLC90f7u5gS7TNEiLcL6j+BGX+pgh1/DxYFF0mftXyRrnw8hxYHs9pqibg3/R0Pt6HTcOOUMIn1gCw8c3VPxxV4VoJv1Cf9XRVhgfD0zOLE/4z2NDjFtw3EWd7snl00IlR3ooJF7JyatcO/bKrJ7mVTWIHbWiJ6D3osYvUR8oE=
Message-ID: <5a2cf1f605031504527979cef4@mail.gmail.com>
Date: Tue, 15 Mar 2005 13:52:47 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: enabling IOAPIC on C3 processor? (how to investigate hangs without nmi watchdog)
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <16950.54895.527127.21123@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
	 <16950.54895.527127.21123@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 13:34:55 +0100, Mikael Pettersson <mikpe@csd.uu.se> wrote:
> jerome lacoste writes:
>  > I have a VIA Epia M10000 board that crashes very badly (and pretty
>  > often, especially when using DMA). I want to fix that.
>  >
>  > Serial console + magic SysRQ didn't help so I am going the nmi
>  > watchdog way. But in order to have nmi watchdog I need APIC, right?
>  >
>  > The C3 processor seems to support IOAPIC.
>  > (http://www.via.com.tw/en/products/processors/c3/specs.jsp)
>  >
>  > But:
>  > - I don't see anything in the BIOS related to APIC.
>  > - grep APIC /lib/modules/`uname -r`/build/.config shows me that all
>  > APIC options are 'y'.
>  > - dmesg | grep APIC tells me "no local APIC present or hardware disabled".
>  > - adding lapic kernel parameter doesn't change that.
>  > - and of course, nmi_watchdog=1 or 2 gives me NMI count 0 in /proc/interrupts.
>  >
>  > Did I miss something when it comes to enabling IOAPIC support on C3 processor?
> 
> Unless you have a pre-release engineering part for a future product,
> then your C3 has no local APIC, and hence no I/O APIC functionality.
> 
> I know some C3 specs pages list I/O APIC support, but if you look in
> the datasheets for current products you find zero APIC support.

My board is 2 years old (May 2003).

I've checked the specs [2] and they say (page 17 out of 83)
"APIC will be available in future steppings."  Yeah right...

Mine is stepping 1 according to /proc/cpuinfo.

So if I don't have APIC, that means I cannot use nmi_watchdog to
investigate the problem, right?

Do I have any alternative to investigate this hang or should I just
give up and smash my board?

Cheers,

Jerome

[2] http://www.via.com.tw/en/downloads/datasheets/processors/c3_nehemiah.zip
