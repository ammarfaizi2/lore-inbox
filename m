Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbUK3MuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUK3MuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUK3MuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:50:06 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57528 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262056AbUK3MuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:50:00 -0500
Message-Id: <200411301249.iAUCnJgs004281@laptop11.inf.utfsm.cl>
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
cc: linux-kernel@vger.kernel.org
Subject: Re: no entropy and no output at /dev/random (quick question) 
In-Reply-To: Message from daw@taverner.cs.berkeley.edu (David Wagner) 
   of "Sat, 27 Nov 2004 19:20:28 -0000." <coak1s$suq$1@abraham.cs.berkeley.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 30 Nov 2004 09:49:19 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daw@taverner.cs.berkeley.edu (David Wagner) said:
> Javier Villavicencio  wrote:
> >it's encouraged to use /dev/urandom instead of /dev/random?

> Yes, for almost all purposes, applications should use /dev/urandom,
> not /dev/random.  (The names for these devices are unfortunate.)

To seed a random number generator, never directly.

> Sadly, many applications fail to follow these rules, and consequently
> /dev/random's entropy pool often ends up getting depleted much faster
> than it has to be.

Reading /dev/urandom depletes exactly the same pool, it just doesn't block
when the pool is empty. As said pool has other uses, indiscriminate reading
of either can DoS other parts of the system.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
