Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTLHLXD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTLHLXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:23:02 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:23817
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S265362AbTLHLXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:23:00 -0500
Date: Mon, 8 Dec 2003 12:22:17 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031208112216.GA925@man.beta.es>
References: <20031130214612.GP2935@mail.muni.cz> <20031207194404.GC13201@mail.muni.cz> <20031207221056.GA2990@man.beta.es> <200312071954.31897.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312071954.31897.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The difference is that GPM (I assume you are using it to get Synaptics

Well, as for me I don't have GPM around for anything, I have this setup in
X both for 2.4 and 2.6:
        Option          "Device"                "/dev/psaux"
        Option          "Protocol"              "auto-dev"

> support) only logs "protocol violations" when in debug mode, and then it
> only checks 2 first bytes. The XFree driver does check the protocol but
> its messages usually don't show up in the syslog. In other words in-kernel
> Synaptics driver just makes the problem apparent it seems.

I had thought something like that some time ago, that I had the problem in
both 2.4 and 2.6, but I only had it reported in 2.6. But testing them I
realised that the behaviour of the mouse is totally different, in 2.6 it
goes mad, while in 2.4 it works perfectly, completely smooth, so I dropped
that idea.

The main difference for my setup of the 2.4 and 2.6 kernels relating mouse
is that on 2.6 I have the Synaptics driver in the kernel and also that in
2.4 I don't have INPUT_* and in 2.6 I have INPUT_MOUSEDEV and INPUT_EVDEV.

I don't know the internals of the drivers here, but I can test whatever you
want, do you think that trying to set this up in 2.6 without Synaptics
support will help us know what is going on? any other test? If so I'll try
them!

If you think about some other tests I can make... just tell me.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
