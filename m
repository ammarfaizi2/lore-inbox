Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265927AbUAKQs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAKQs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:48:59 -0500
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:32721 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S265927AbUAKQs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:48:58 -0500
Message-ID: <40017E7A.4070500@metrowerks.com>
Date: Sun, 11 Jan 2004 17:48:58 +0100
From: Bernhard Kuhn <bkuhn@metrowerks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [announcement, patch] real-time interrupts for the Linux kernel
References: <3FFE078D.20400@metrowerks.com> <1073827448.9096.119.camel@nosferatu.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:

> Do you have actual benchmarks,

The example kernel module and application are doing
some simple benchmarking: the local APIC timer
runs in period mode (1 kHz), and the interrupt
handler then reads out the current value of the timer.
Then you know how long it took from the occurence of the
interrupt to the moment the handler has been invoked
(including context switching, do_IRQ and handle_IRQ_event).

Number is my setup under heavy load (ping-flood, glxgears):

                     99.9%     worst case
high priority        3.1 탎       5.2 탎
standard kernel    486.1 탎     500.8 탎

"99.9%" means that 99.9% of the interrupts or handled
in withing the given time.


> and what 2.4 rather than 2.6 ?

I started with 2.4 becuase that's the devil i know, but from
what i have inspected so far, adopting this scheme for 2.6
should be doable within a day - i just started to work in it.

best regards

Bernhard

