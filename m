Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276547AbRJCQ64>; Wed, 3 Oct 2001 12:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276540AbRJCQ6g>; Wed, 3 Oct 2001 12:58:36 -0400
Received: from www.transvirtual.com ([206.14.214.140]:45829 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276554AbRJCQ6Y>; Wed, 3 Oct 2001 12:58:24 -0400
Date: Wed, 3 Oct 2001 09:58:30 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
In-Reply-To: <20011003101944.29249@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.10.10110030955470.32026-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, there are indeed a few improvements to get with machine specific
> optimisations on unaccelerated framebuffer.
[snip]...

Neat trick. Please note also that no read operations to the framebuffer
are done by the fbcon layer. Such reads should be to the shadow buffers
(vc_screenbuffer) instead. Reading the framebuffer is a userland operation
and as such you really only tricks for reading in userland. 

