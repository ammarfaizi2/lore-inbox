Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSBTBsS>; Tue, 19 Feb 2002 20:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBTBsI>; Tue, 19 Feb 2002 20:48:08 -0500
Received: from L0545P29.dipool.highway.telekom.at ([62.46.132.29]:57733 "EHLO
	pitt.yi.org") by vger.kernel.org with ESMTP id <S290796AbSBTBsB>;
	Tue, 19 Feb 2002 20:48:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christoph Pittracher <pitt@gmx.at>
Organization: PITT
Message-Id: <200202200237.28577@pitt4u.2y.net>
To: Jean Paul Sartre <sartre@linuxbr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
Date: Wed, 20 Feb 2002 02:47:48 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0202192220550.13176-100000@sartre.linuxbr.com>
In-Reply-To: <Pine.LNX.4.40.0202192220550.13176-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wednesday 20 February 2002 02:26, Jean Paul Sartre wrote:
> 	I was grepping through the SIS malloc/free code and I saw DRM
> 'shares' code with the fb code. What if I have SIS framebuffer
> disabled and SIS DRM code enabled? In 2.4.18-rc2, the SIS DRM code
> does not compile from the lack of sis_malloc and sis_free function.

Yes, the sisfb/drm code has some design lacks.
Another lack is the necessary memory offset between framebuffer/drm and 
the X driver (see http://www.webit.at/~twinny/linuxsis630.shtml for 
details).

> 	I would suggest 'duplicating' this code (yes, I *do* hate
> duplicating codes) or making that memory allocation code *really*
> shared between both modules (or we won't be able to successfully
> compile it, since the DRM code is on drivers/char/drm and the FB code
> is on drivers/video/sis/sis_main.c).

I don't think that it would be a problem to duplicate the code. the 
sis_malloc / sis_free functions seems quite stable. I don't think that 
there will be big updates for this code.

> 	If the suggestion of 'duplicating' code (argh) is reasonable
> enough (for they are really different codes) I can work and submit a
> patch.

Thomas Winischhofer <tw@webit.com> is working on that SiS stuff for 
about 2 months. I think it would be best if you contact him and ask 
what he thinks about that. I know that he said it would be a good idea 
to seperate the sisfb and sis_drm code but he doesn't have enough time 
to do it...

regards,
Christoph
