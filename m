Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319657AbSIMO2N>; Fri, 13 Sep 2002 10:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319658AbSIMO2N>; Fri, 13 Sep 2002 10:28:13 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:12781 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319657AbSIMO2M>; Fri, 13 Sep 2002 10:28:12 -0400
Date: Fri, 13 Sep 2002 08:33:15 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17pr8P-00089M-00@starship>
Message-ID: <Pine.LNX.4.44.0209130820410.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:
> > Because in your example, my_module_start() would not be able to run 
> > separately
> 
> That's obvious.  What hasn't been shown is why that's necessary.

Yeah, but it was also obvious that my_module_init() can fail this way. 
Look, first we watch the module initialization, that is, we run the 
critical stuff like resource allocation, data structure allocation, etc. 
If we fail here, we can't load the module, because it would be unoperative 
if we proceed. (Because the data simply isn't there.)

And possibly Rusty wanted to avoid a certain race, which is unrelated to
school and kids. Once we've initialized, the module can be used, earlier
is balderdash.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

