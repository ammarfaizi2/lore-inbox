Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbSKPFy2>; Sat, 16 Nov 2002 00:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbSKPFy2>; Sat, 16 Nov 2002 00:54:28 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:64009 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267224AbSKPFy1>; Sat, 16 Nov 2002 00:54:27 -0500
Date: Sat, 16 Nov 2002 17:01:07 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andrew Morton <akpm@digeo.com>
cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47-mm3
In-Reply-To: <3DD58A9E.2580F85D@digeo.com>
Message-ID: <Mutt.LNX.4.44.0211161659150.10154-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Andrew Morton wrote:

> Con Kolivas wrote:

> > In file included from include/net/xfrm.h:6,
> >                  from net/core/skbuff.c:61:
> > include/linux/crypto.h: In function `crypto_tfm_alg_modname':
> > include/linux/crypto.h:202: dereferencing pointer to incomplete type
> 
> Looks like you have CONFIG_MODULES=n, but crypto_tfm_alg_modname()
> is unconditionally accessing module->name.
> 

This will be fixed with Rusty's module_name() patch.


- James
-- 
James Morris
<jmorris@intercode.com.au>


