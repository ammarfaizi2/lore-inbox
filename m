Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266875AbUGLPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266875AbUGLPb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbUGLPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:31:26 -0400
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:9932 "EHLO
	srvsec1.girce.epro.fr") by vger.kernel.org with ESMTP
	id S266875AbUGLPbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:31:24 -0400
Message-ID: <0cee01c46825$4d9f2310$3cc8a8c0@epro.dom>
From: "Colin LEROY" <colin@colino.net>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: <michael@mihu.de>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
References: <20040712082545.GA416@jack.colino.net> <Pine.GSO.4.58.0407121718270.17199@waterleaf.sonytel.be>
Subject: Re: [PATCH] fix saa7146 compilation on 2.6.8-rc1
Date: Mon, 12 Jul 2004 17:31:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 12 Jul 2004 colin@colino.net wrote:
> > this patch fixes a compilation error on 2.6.8-rc1. Here's the error:
> > drivers/media/common/saa7146_video.c:3: conflicting types for `memory'
> > include/asm-m68k/setup.h:365: previous declaration of `memory'
> > make[3]: *** [drivers/media/common/saa7146_video.o] Error 1
> 
> But there's nothing named plain `memory' in include/asm-m68k/setup.h?!?!?
> Actually there never has been...

Right, but (i should have specified, sorry), I compiled on ppc32, and there's

#define m68k_num_memory num_memory
#define m68k_memory memory
#include <asm-m68k/setup.h

in include/asm-ppc/setup.h. 

-- 
Colin
