Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbTCSOyZ>; Wed, 19 Mar 2003 09:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTCSOyY>; Wed, 19 Mar 2003 09:54:24 -0500
Received: from [213.171.53.133] ([213.171.53.133]:14350 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S263081AbTCSOyX>;
	Wed, 19 Mar 2003 09:54:23 -0500
Date: Wed, 19 Mar 2003 18:09:23 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <861563974656.20030319180923@wr.miee.ru>
To: Adam Belay <ambx1@neo.rr.com>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
In-Reply-To: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JK> Following patch is to make ESS968 driver to work with PNP API.
[SNIP]
JK> +static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
[SNIP]
      Hello, Adam, Greg and other.
As I think in this section of kernel it's not necessarily to use
__devinit and __devexit.
Soundcards(and other devices) can't be HotPlug as I know.
And if we look at #define of this attributes, then we see that
it useless with not HotPlug devices.

180 #ifdef CONFIG_HOTPLUG
181 #define __devinit
182 #define __devinitdata
183 #define __devexit
184 #define __devexitdata
185 #else
186 #define __devinit __init
187 #define __devinitdata __initdata
188 #define __devexit __exit
189 #define __devexitdata __exitdata
190 #endif
And with changes from __init to __devinit and enabled CONFIG_HOTPLUG
we loose advantage of __init.
May be I've missed something?
       Best regards, Ruslan.

