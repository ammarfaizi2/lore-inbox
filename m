Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVAYT67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVAYT67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVAYT5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:57:44 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49284 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261674AbVAYTzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:55:35 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with 2.6.11-rc2
Date: Tue, 25 Jan 2005 11:55:20 -0800
User-Agent: KMail/1.7.1
Cc: Pete Zaitcev <zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251155.20430.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Pete Zaitcev:
> ALPS Touchpad (Dualpoint) detected
>   Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1

I have problems with an ALPS on serio4 ... different ones though.  And
it may be that RC2 is a bit better here than previous kernels.

For example, it says it disabled tapping -- but it's still active.
Evidently there are model-specific differences that the ALPS driver
doesn't handle correctly.


> Looks like detection is correct, however either ALPS specific code doesn't work
> right, or it sets wrong parameters, I cannot tell. Here's the list of problems,
> from worst to least annoying:
> 
> - Very often, keyboard stops working after a click. Typing anything has no effect.
>   However, any smallest pointer movement will restore keyboard, and then an
>   application receives all buffered characters. This is very bad.

I've got similar interactions between keyboard and touchpad -- no-effect, than
after magic to unblock, a flood of characters.  The Way To Fix It is different
though.  There seems to be an interaction with window focus, since another
symptom is that for example there's no cursor in the active window ... until
it's fixed.  Sometimes things like newlines will cause scrolling, without any
other characters appearing... maybe there's a KDE/x86_64 interaction too.

 
> - Double-click sometimes fails to work. I have to wait a second and retry it.
>   Retrying right away is likely not to work again.
> 
> - Slow motion of finger produces no motion, then a jump. So, it's very hard to
>   target smaller UI elements and some web links.

I don't think I've seen either of those two problems.


I have two problems during mouse motion.  One of them is that sometimes it seems
to stop working or go into ultra-slow tracking mode.  Workaround:  wait a second,
start again; it's as if there's some timed mode that it automagically enters/exits.

The more serious one is that sometimes it seems to spontaneously emit click
events while I'm moving finger across pad.  Which means I've had to learn to
plan my "mouse" motions to avoid areas where clicking could have bad effects.
But that's not always possible ...

- Dave
 

