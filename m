Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbTCWEXp>; Sat, 22 Mar 2003 23:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTCWEXp>; Sat, 22 Mar 2003 23:23:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24836 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262428AbTCWEXo>; Sat, 22 Mar 2003 23:23:44 -0500
Date: Sat, 22 Mar 2003 20:33:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <linux@brodo.de>, Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] pcmcia (2/5): add bus_type pcmcia_bus_type
In-Reply-To: <20030322160032.GB12342@brodo.de>
Message-ID: <Pine.LNX.4.44.0303222030360.5588-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Mar 2003, Dominik Brodowski wrote:
>
> Register a bus_type pcmcia_bus_type. This means the initialization of
> the ds module needs to be done in two levels: one quite early
> (subsys_initcall) so that drivers may use the bus_type; the other one
> must stay that late (late_initcall). As only one initcall can be
> specified within one module, some tweaking is needed.

Hmm.. We should fix the module interface instead. 

I've applied this patch, but there's no reall reason why modules 
shouldn't be able to have multiple initcalls.

Having drivers behave differently whether they are compiled in or as
modules is not a good thing. Rusty?

		Linus

