Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTFAUxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTFAUxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:53:48 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:31361
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264728AbTFAUxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:53:46 -0400
Date: Sun, 1 Jun 2003 16:56:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Willy Tarreau <willy@w.ods.org>,
       Daniel Podlejski <underley@underley.eu.org>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx problem
In-Reply-To: <2859720000.1054499680@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.50.0306011647431.19313-100000@montezuma.mastecende.com>
References: <20030531165945.GA5561@witch.underley.eu.org>
 <20030601083656.GI21673@alpha.home.local> <2859720000.1054499680@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Justin T. Gibbs wrote:

> > Hmmm that makes quite a difference ! I didn't understand what happened between
> > these two outputs. Also, did you try with Justin's latest version of the driver:
> > 
> 
> My driver can't fix interrupt routing issues which is what Daniel's
> problem turned out to be.  I'm really tempted to add an interrupt
> test to the driver attach so that these kinds of problems are clearly
> flagged and my driver doesn't continue to get blamed for interrupt
> routing it can't control.

Which aspect of interrupt routing is broken so that we at least can have a 
go at fixing it? I might be missing something here but it looks fine, 
could you elaborate?

2.4.18

IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ28 -> 1:12
IRQ29 -> 1:13

          CPU0       CPU1       CPU2       
  0:    3354580    4108947    4515468    IO-APIC-edge  timer
  1:          2          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          XT-PIC  cascade
  4:        434        467        729    IO-APIC-edge  serial
  8:          1          0          0    IO-APIC-edge  rtc
 19:      73764      78100      80631   IO-APIC-level  eth0
 28:     301389     301350     302498   IO-APIC-level  aic7xxx
 29:      79542      82186      83042   IO-APIC-level  aic7xxx
NMI:   11978872   11978872   11978872 
LOC:   11978887   11978722   11978731 
ERR:          0
MIS:          0

2.5.70

IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ28 -> 1:12
IRQ29 -> 1:13

<no /proc/interrupts because it never makes it to a single user prompt>

-- 
function.linuxpower.ca
