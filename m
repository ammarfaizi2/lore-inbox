Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135869AbRDYO77>; Wed, 25 Apr 2001 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135870AbRDYO7s>; Wed, 25 Apr 2001 10:59:48 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:1555 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S135869AbRDYO7q>; Wed, 25 Apr 2001 10:59:46 -0400
Message-Id: <200104251459.f3PEx8s4009505@pincoya.inf.utfsm.cl>
To: "Sergey Kubushin" <ksi@cyberbills.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3ac13 
In-Reply-To: Message from "Sergey Kubushin" <ksi@cyberbills.com> 
   of "Tue, 24 Apr 2001 16:00:23 MST." <Pine.LNX.4.31ksi3.0104241559530.1039-100000@nomad.cyberbills.com> 
Date: Wed, 25 Apr 2001 10:59:08 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey Kubushin" <ksi@cyberbills.com> said:
> === Cut ===
> [root@nomad /root]# depmod -ae
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.3ac13/kernel/drivers/net/aironet4500_card.o
> depmod:         __bad_udelay
> === Cut ===

AFAIR, this means that the driver is using an udelay() with a much too
large argument. Break it up into several shorter ones, or use mdelay().
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
