Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUAJThu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUAJTf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:35:26 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:9127 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265338AbUAJTeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:34:05 -0500
Date: Sat, 10 Jan 2004 20:34:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] atkbd.c: Unknown key released
Message-ID: <20040110193404.GB22654@ucw.cz>
References: <20040110183116.GA8319@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110183116.GA8319@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 07:31:16PM +0100, Rudo Thomas wrote:

> Hello.
> 
> This line shows up twice in dmesg when starting up X.
> 
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> 
> Tried with 2.6.1, 2.6.1-mm1. It does not happen in 2.6.0, IIRC. I don't seem to
> be able to reproduce the message by pressing any combination on keyboard.
> 
> Full dmesg output is atteched.

This is a bug in X. It talks directly to the keyboard controller. And
that's a rather nasty one. I got a couple reports of "My keyboard stops
working in X", and this is exactly why. X can rather easily confuse the
controller by talking to it in parallel with the kernel driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
