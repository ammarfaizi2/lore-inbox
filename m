Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319591AbSIHK3z>; Sun, 8 Sep 2002 06:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319592AbSIHK3z>; Sun, 8 Sep 2002 06:29:55 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:6802 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S319591AbSIHK3z>; Sun, 8 Sep 2002 06:29:55 -0400
Date: Sun, 8 Sep 2002 12:57:48 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209080952410.16565-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209081250000.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Ingo Molnar wrote:

> hm, perhaps it could confuse some of the more complex shared-IRQ-aware
> device drivers, such as IDE. But your patch is very tempting nevertheless,
> it removes much of the disadvantage of sharing interrupt lines. Most of
> the handlers on the chain are supposed to be completely independent.

iirc IDE is capable of doing its own masking per device(nIEN) and in fact 
does even do unconditional sti's in its isr paths. So i would think it 
would be one of the not so painful device drivers to take care of. 
DISCLAIMER: I am not Andre Hedrick

	Zwane
-- 
function.linuxpower.ca

