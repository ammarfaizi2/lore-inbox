Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSFVRXT>; Sat, 22 Jun 2002 13:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFVRXS>; Sat, 22 Jun 2002 13:23:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:4587 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316649AbSFVRXR>; Sat, 22 Jun 2002 13:23:17 -0400
Date: Sat, 22 Jun 2002 12:23:15 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Andries.Brouwer@cwi.nl
cc: jgarzik@mandrakesoft.com, <linux-kernel@vger.kernel.org>
Subject: Re: ethernet name clash at boot
In-Reply-To: <UTC200206221712.g5MHCGU08868.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0206221220420.7338-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002 Andries.Brouwer@cwi.nl wrote:

> On a machine with a handful of ethernet cards things go wrong
> when booting 2.5.24. Backing out the change that makes
> net_dev_init() into an initcall in net/core/dev.c solves
> the problem (no doubt accidentally).
> 
> More precisely, what happens is that two cards both get assigned
> eth0, and then when the second one wants to register the error
> -EEXIST is returned.
> 
> Thus, some more locking is required, or names must only be given
> to things in the dev_base chain, or ...

Hmmh, I did that change (being aware of the potential to cause breakage, 
though I actually thought it should be fine), so I'll go try figure out
what's going wrong. Can you give some more info on your config (which
ethernet drivers are built-in, and which ethernet cards do you have in 
your box).

--Kai


