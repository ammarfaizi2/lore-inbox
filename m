Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRIOKUz>; Sat, 15 Sep 2001 06:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272206AbRIOKUq>; Sat, 15 Sep 2001 06:20:46 -0400
Received: from s340-modem2130.dial.xs4all.nl ([194.109.168.82]:2256 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S272197AbRIOKU1>;
	Sat, 15 Sep 2001 06:20:27 -0400
Date: Sat, 15 Sep 2001 11:44:57 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <1000479851.2156.12.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109151131320.32167-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 14 Sep 2001, Robert Love wrote:

> On Fri, 2001-09-14 at 02:40, Arjan Filius wrote:
> > Hello Robert,
>
> Hi Arjan,
>
> > I do Athlon/K7 opmimization indeed, and didn't test without.
> > Haven't stress-tested it very well yet, but as soon i notice something i
> > let you know.
>
> Have you had any oops that were unexplained, after we fixed the other
> problems?
Didn't discover yet, the only "strange" thing is when using <TAB>
autocompleteion in a kterm in kde i get every time a kde crash-bug-report
popup message. however, no kernel messages or whatsoever.


>I have attached the patch below, you can give it a whirl, but
> it is odd you have had no problems.

Well it's a fpu patch, and as far as i know i don't use the fpu that much
at the moment but i'll try that.

in the hope finding the usage of fpu-irq:
sjoerd:/usr/src/linux # cat /proc/interrupts
           CPU0
  0:   13374740          XT-PIC  timer
  1:      14581          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:     238018          XT-PIC  usb-uhci, usb-uhci, EMU10K1
 10:     601500          XT-PIC  ide2, sym53c8xx
 11:      87300          XT-PIC  eth0
 12:     230338          XT-PIC  PS/2 Mouse
 14:     331764          XT-PIC  ide0
 15:      39468          XT-PIC  ide1
NMI:          0
ERR:          0

But /proc/interrupts shows only those irq's which are currently in use, is
there any way to show usage of currenlty unused interrupts?

Greetings,

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

