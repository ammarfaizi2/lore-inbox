Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTL2WAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTL2WAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:00:24 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:21952 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264288AbTL2WAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:00:23 -0500
Date: Mon, 29 Dec 2003 22:59:13 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Berg Larsen <pebl@math.ku.dk>,
       Santiago Garcia Mantinan <manty@manty.net>,
       Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org,
       andrew.grover@intel.com
Subject: ACPI problems (was: Re: Synaptics PS/2 driver and 2.6.0-test11)
Message-ID: <20031229215913.GH916@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found that problem with synaptics is really related to some ACPI troubles.
I've suspected synaptics touchpad to do some interrupt bursts and it does.
Just single button press and relelase generates about 500 interrupts!!! I wonder
if it is driver related or really hardware related...

I've found that modem driver (slamr module for built in soft modem) suffers from
the same problem. Gnome battery stat applet freezes connection. 

However with 2.4.23 kernel is all OK. So it seems to be something broken with
ACPI. 

I remind that gnome battery stat applet causes many lost interrupts. (Interrupt
timeout in i8042.c)

-- 
Luká¹ Hejtmánek
