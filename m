Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268929AbTBZUik>; Wed, 26 Feb 2003 15:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268930AbTBZUii>; Wed, 26 Feb 2003 15:38:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:164 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S268929AbTBZUif>;
	Wed, 26 Feb 2003 15:38:35 -0500
Message-Id: <200302262047.h1QKlm0P001784@eeyore.valparaiso.cl>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
cc: jt@hpl.hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Invalid compilation without -fno-strict-aliasing 
In-Reply-To: Your message of "26 Feb 2003 17:04:05 BST."
             <873cmbghai.fsf@student.uni-tuebingen.de> 
Date: Wed, 26 Feb 2003 17:47:48 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Falk Hueffner <falk.hueffner@student.uni-tuebingen.de> said:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> > Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > > 	if((stream + event_len) < ends) {
> > > 		iwe->len = event_len;
> > > 		memcpy(stream, (char *) iwe, event_len);
> > > 		stream += event_len;
> > > 	}
> > > 	return stream;
> > > }
> > 
> > The compiler is free to assume char *stream and struct iw_event *iwe
> > point to separate areas of memory, due to strict aliasing.
> 
> The relevant paragraph of the C99 standard is:
> 
> An object shall have its stored value accessed only by an lvalue
> expression that has one of the following types:
[...]
> -- a character type.

(char *) gives you a (pointer to) a character type.

> I can't really spot any lvalue here that might violate this rule.  It
> would be nice if somebody could report a bug with a testcase.

stream and (char *) iwe
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
