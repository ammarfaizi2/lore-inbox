Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTLNXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTLNXLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:11:09 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:17386 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262761AbTLNXLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:11:06 -0500
Date: Mon, 15 Dec 2003 00:10:37 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Berg Larsen <pebl@math.ku.dk>,
       Santiago Garcia Mantinan <manty@manty.net>,
       Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031214231037.GS13201@mail.muni.cz>
References: <Pine.LNX.4.40.0312081021080.10795-100000@shannon.math.ku.dk> <200312081316.47899.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312081316.47899.dtor_core@ameritech.net>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 01:16:46PM -0500, Dmitry Torokhov wrote:
> You are right, Synaptics does check entire packet and reports it, 
> unfortunately many (most) distributions kill almost all GPM messages
> because it's too noisy.
> 
> Anyway, I wonder if the patch below will help sync problem. If it does
> then we can kill the warning message later.
> 
> The patch should apply to -test11 although will complain about offset
> as I have some extra stuff in my tree.

I did apply.


Dec 14 23:44:21 debian kernel: Synaptics driver lost sync at 4th byte
Dec 14 23:44:21 debian kernel: Synaptics driver lost sync at 1st byte
Dec 14 23:44:21 debian kernel: psmouse: bad data from KBC - timeout
Dec 14 23:44:21 debian kernel: Synaptics driver resynced.
Dec 14 23:46:22 debian kernel: Synaptics driver lost sync at 4th byte
Dec 14 23:46:22 debian kernel: Synaptics driver lost sync at 1st byte
Dec 14 23:46:22 debian kernel: psmouse: bad data from KBC - timeout
Dec 14 23:46:22 debian kernel: Synaptics driver resynced.

However I did notice that it does hurt while xmms is playing (via alsa on i810
card). If I turn off xmms then it is a lot better. It is hard to reproduce those
messages without xmms. (mpg123 does it as well as xmms).

-- 
Luká¹ Hejtmánek
