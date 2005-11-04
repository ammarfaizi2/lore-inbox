Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbVKDMW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVKDMW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbVKDMW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:22:57 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22160 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932725AbVKDMW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:22:56 -0500
Message-Id: <200511041221.jA4CLk78004933@laptop11.inf.utfsm.cl>
To: "David S. Miller" <davem@davemloft.net>
cc: vonbrand@inf.utfsm.cl, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense 
In-Reply-To: Message from "David S. Miller" <davem@davemloft.net> 
   of "Sun, 30 Oct 2005 06:39:23 -0800." <20051030.063923.14657004.davem@davemloft.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 04 Nov 2005 09:21:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 04 Nov 2005 09:21:48 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
> From: Horst von Brand <vonbrand@inf.utfsm.cl>
> Date: Sun, 30 Oct 2005 00:26:33 -0300
> 
> > > Sun keyboard can be autodetected AFAIK so you don't need to fiddle with
> > > inputattach.
> > 
> > The setup works for the shipped Aurora kernel, but to compile that
> > configuration would take a few days...

> Do you try to load any keymaps at boot time?
> Try to disable that.

Finally found the culprit: SERIAL_SUNZILOG can't be module (or has to be
loaded early, dunno). The Aurora setup tries to load keymaps, and disabling
that made no difference.

Thanks all for the help!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

