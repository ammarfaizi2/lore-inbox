Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTLTBwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 20:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLTBwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 20:52:31 -0500
Received: from vitelus.com ([64.81.243.207]:58565 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263772AbTLTBw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 20:52:29 -0500
Date: Fri, 19 Dec 2003 17:51:31 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: psmouse synchronization loss under load
Message-ID: <20031220015131.GB9834@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a Dell laptop whenever I run a program that takes the full CPU, my
mouse pointer goes insane and thrashes my X session every few minutes.
It seems to have a mind of its own and always be able to make it to
the Exit item in the root menu ;). Whenever this happens, psmouse logs
and detects the error:

psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing
2 bytes away.

The pointing device itself is a Synaptics touchpad. I don't use the
synaptics driver because every time I've tried it (intentionally and
when forced to by older development kernels) it simply rendered the
touchpad inoperative.

I'm running a late snapshot of 2.6.0-test11 which for all intents and
purposes is the same as 2.6.0. The problem that I described happens
with other versions of the 2.6.0-test series. I upgraded to this
snapshot a few days ago to make sure I could reproduce the problem.
