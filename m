Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVA2TKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVA2TKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVA2TJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:09:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:59598 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261541AbVA2TIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:14 -0500
Date: Fri, 28 Jan 2005 21:05:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128200512.GA3014@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com> <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com> <41FA90F8.6060302@poczta.onet.pl> <d120d5000501281127752561a3@mail.gmail.com> <41FA972F.2000604@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA972F.2000604@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:49:03PM +0100, Wiktor wrote:
> Hi,
> 
> >Could you please try editing drivers/input/serio/i8042.c and add
> >udelay(20) before and after calls to i8042_write_data() in
> >i8042_kbd_write() and i8042_command().
> 
> of course i could, will it make kernel not detect smoked AUX port? 
> (problem is solved by i8042.noaux=1 cause my hardware has smoked PS/2 
> port) i would rather think about testing devices before assuming thet 
> work and trying to use them (maybe not as standard kernel feature, but 
> it would be nice stuff for people with self-built machines where not 
> everything works). Thanks for your help
 
Well, the kernel tests the AUX port and it seemed OK, that's the
problem. Unfortunately it's not always possible to detect whether
there's a problem with some device.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
