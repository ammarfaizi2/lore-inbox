Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUKALDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUKALDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKALDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:03:00 -0500
Received: from aun.it.uu.se ([130.238.12.36]:50319 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261517AbUKALC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:02:58 -0500
Date: Mon, 1 Nov 2004 12:02:45 +0100 (MET)
Message-Id: <200411011102.iA1B2jbX012340@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: Re: unit-at-a-time...
Cc: linux-kernel@vger.kernel.org, pluto@pld-linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Nov 2004 02:39:41 +0100, Andi Kleen wrote:
>> Disabling unit-at-a-time for i386 is definitely correct.
>> I've personally observed horrible runtime corruption bugs
>> in early 2.6 kernels when they were compiled with gcc-3.4
>> without the -fno-unit-at-a-time fix.
>
>Maybe you got a buggy gcc version. The 2.6.5 based SLES9/i386
>kernel is shipping with -funit-at-a-time compiled with a 3.3-hammer
>compiler and I am not aware of any reports of stack overflow
>(and that kernel is extremly well tested) 

It happened when I added perfctr to a 2.6.5-based SuSE kernel,
and compiled the whole thing with gcc-3.4.0 (or 3.4.1, don't
remember). Perfctr normally adds a little stack usage to the
context-switch path, but gcc-3.4 made it much worse.
Disabling unit-at-a-time solved the problem.

/Mikael
