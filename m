Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTCGEME>; Thu, 6 Mar 2003 23:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCGEME>; Thu, 6 Mar 2003 23:12:04 -0500
Received: from fmr02.intel.com ([192.55.52.25]:41416 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261339AbTCGEMD> convert rfc822-to-8bit; Thu, 6 Mar 2003 23:12:03 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780AB91FA2@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>,
       "'prash_t@softhome.net'" <prash_t@softhome.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Inconsistency in changing the state of task ??
Date: Thu, 6 Mar 2003 20:22:30 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thanks Robert for the reply.
> > But I notice that __set_current_state() is same as current->state. So, I
> > didn't understand the safety factor on using __set_current_state( ).
> 
> There is no safety with __set_current_state().  It is just an
> abstraction.
> 
> The safety comes from set_current_state(), which ensures memory
> ordering.
> 
> This is an issue not just on SMP, but on a weakly ordered processor like
> Alpha.
> 
> > Also why should I use __set_current_state() instead of
> set_current_state()
> > when the later is SMP safe.
> 
> You only use __set_current_state() if you know you do not need to ensure
> memory ordering constraints.

Man, I forgot how many times I have already posted the patch to fix this ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)


