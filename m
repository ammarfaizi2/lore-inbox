Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUDXTmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUDXTmw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 15:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUDXTmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 15:42:52 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:7696 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262547AbUDXTmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 15:42:50 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Sebastian Witt <se.witt@gmx.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, frankt@promise.com
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
Date: Sat, 24 Apr 2004 22:42:36 +0300
User-Agent: KMail/1.5.4
References: <40898ADA.8020708@hasw.net>
In-Reply-To: <40898ADA.8020708@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404242242.36154.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 April 2004 00:30, Sebastian Witt wrote:
> Hello,
>
> I'm getting some Oopses with kernel 2.6.5 when there is high load on
> both channels of a Promise PDC20262 (Ultra66) card on a SMP machine
> (Tyan S1834, Via Apollo Pro chipset).

I recall similar report. Reporter found that there is a #define
in the source which can be enabled to make driver serialize access
to channels. That 'fixed' (most probably worked around, though)
the problem.

I can't say whether it was a hardware or driver problem,
I didn't look into it.

> There are no problems when I use 2.6.1, but I have this problem
> since 2.6.2.
> It only occurs when I use the PDC20262, not when using the onboard
> IDE-controller.
>
> It is reproduceable after a few seconds when I use 'dd if=/dev/hde
> of=/dev/hdh bs=512'.
> Using of=/dev/null also works, but it takes longer.
>
> Mostly it reports smp_apic_timer_interrupt+1c/140, but the last time
> I tried it, it also reports <__mask_IO_APIC_irq+40/e0>.
>
> I've attached the logs and the ksymoops trace.
--
vda

