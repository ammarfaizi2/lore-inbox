Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319592AbSIMKIJ>; Fri, 13 Sep 2002 06:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319593AbSIMKII>; Fri, 13 Sep 2002 06:08:08 -0400
Received: from [217.167.51.129] ([217.167.51.129]:51179 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S319592AbSIMKII>;
	Fri, 13 Sep 2002 06:08:08 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, PPC and AGP
Date: Fri, 13 Sep 2002 12:12:45 +0200
Message-Id: <20020913101245.591@192.168.4.1>
In-Reply-To: <Pine.LNX.4.44L.0209131115460.5612-100000@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.44L.0209131115460.5612-100000@alpha.zarz.agh.edu.pl>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>I try to compile 2.4.19 [2.4.20-pre7 too] on PPC.
>But in file drivers/char/agp/agpgart_be.c in function flush_cache 
>line 68-86 isn't defined PowerPC.
>
>Thanx.
>					Sas.
>Here is small patch to fix this:

Unless you are working on your own driver for a board with AGP,
the agpgart found in the main tree is of no help on PPC.

I have an implementation for Apple's AGP controller in the
pmac tree, though it's not really clean enough to be merged
upstream yet and requires additional tweaks to the DRM. So far,
I'm not satisfied with DRI stability when using AGP, which is
the main reason why all this stuff isn't pushed upstream.

Ben.


