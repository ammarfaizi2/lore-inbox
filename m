Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbSKQCVb>; Sat, 16 Nov 2002 21:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbSKQCVb>; Sat, 16 Nov 2002 21:21:31 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:34354
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267435AbSKQCVb>; Sat, 16 Nov 2002 21:21:31 -0500
Date: Sat, 16 Nov 2002 21:31:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: John Levon <levon@movementarian.org>
cc: Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: NMI handling rework for x86
In-Reply-To: <20021117020017.GA96715@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0211162128450.1543-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2002, John Levon wrote:

> One thing: since we have the unnatural relationship between the watchdog
> and oprofile, I would much prefer that be obvious in the priority. e.g
> MAX_NMI_PRIORITY, which oprofile uses, then watchdog is MAX_NMI_PRIORITY
> -1. Currently the gap between the two values you use indicates it's OK
> to have another handler inbetween, which it definitely isn't.

Hmm how about when the machine really is in trouble, we really wouldn't 
want some things to be running when we want the watchdog to trigger. How 
do you propose we handle this? nmi_watchdog_tick is pretty light so it has 
a lesser chance of blowing up in various code when the machine is on the 
brink of death.

150,000? Nice Corey, again i stand corrected on that front.

	Zwane
-- 
function.linuxpower.ca

