Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290730AbSBTB1R>; Tue, 19 Feb 2002 20:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290741AbSBTB1H>; Tue, 19 Feb 2002 20:27:07 -0500
Received: from traven.uol.com.br ([200.231.206.184]:29110 "EHLO
	traven.uol.com.br") by vger.kernel.org with ESMTP
	id <S290730AbSBTB0s>; Tue, 19 Feb 2002 20:26:48 -0500
Date: Tue, 19 Feb 2002 22:26:37 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sis_malloc / sis_free
Message-ID: <Pine.LNX.4.40.0202192220550.13176-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello all.

	I was grepping through the SIS malloc/free code and I saw DRM
'shares' code with the fb code. What if I have SIS framebuffer disabled
and SIS DRM code enabled? In 2.4.18-rc2, the SIS DRM code does not compile
from the lack of sis_malloc and sis_free function.

	I would suggest 'duplicating' this code (yes, I *do* hate
duplicating codes) or making that memory allocation code *really* shared
between both modules (or we won't be able to successfully compile it,
since the DRM code is on drivers/char/drm and the FB code is on
drivers/video/sis/sis_main.c).

	If the suggestion of 'duplicating' code (argh) is reasonable
enough (for they are really different codes) I can work and submit a
patch. If not, I do not know how to 'share' both codes without tweaking
through the makefiles and dependencies (which should also compile extra
code that is not needed in the DRM code).

	Regards,
	Cesar Suga <sartre@linuxbr.com>


