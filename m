Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbTIMSwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTIMSwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:52:51 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:52484 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261958AbTIMSwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:52:49 -0400
Date: Sat, 13 Sep 2003 20:52:44 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030913205244.A3295@pclin040.win.tue.nl>
References: <2F284368A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2F284368A@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Fri, Sep 12, 2003 at 08:33:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 08:33:24PM +0200, Petr Vandrovec wrote:

> Andries is already gathering info for this one. This problem (missed
> key release) happens to me on all systems I have (Athlon + via, P3 + i440BX,
> P4 + 845...), most often when I do alt+right-arrow for walking through
> consoles (and for Andries: hitting key stops this, otherwise it 
> endlessly switches all VTs around, and while kernel thinks that key
> is down, keyboard actually does not generate any IRQs, so keyboard knows
> that all keys are released).

OK. It seems to me the two main hypotheses are: (i) problem with timers,
(ii) problem with keyboard.

In other words: could you (and/or anybody else who can reproduce this
at will) change the #undef DEBUG in i8042.c to #define DEBUG, recreate
the problem, and post or mail the resulting file with keystrokes?

[of course: cut away parts corresponding to login sequences etc.]

This will probably allow us to decide whether the missing key release
was never sent by the keyboard, or was lost by the kernel.

Andries
aeb@cwi.nl

