Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbRGCRgd>; Tue, 3 Jul 2001 13:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRGCRgX>; Tue, 3 Jul 2001 13:36:23 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:12561 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S265610AbRGCRgL>; Tue, 3 Jul 2001 13:36:11 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200107031735.TAA00455@green.mif.pg.gda.pl>
Subject: Re: RFC: modules and 2.5
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 3 Jul 2001 19:35:22 +0200 (CEST)
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> A couple things that would be nice for 2.5 is
> - let MOD_INC_USE_COUNT work even when module is built into kernel, and
> - let THIS_MODULE exist and be valid even when module is built into
> kernel
> 
> This introduces bloat into the static kernel for modules which do not
> take advantage of this, so perhaps we can make this new behavior
> conditional on CONFIG_xxx option.  Individual drivers which make use of
> the behavior can do something like
> 
> 	dep_tristate 'my driver' CONFIG_MYDRIVER $CONFIG_PCI
> 	if [ "$CONFIG_MYDRIVER" != "n" -a \
              ^^^^^^^^^^^^^^^^^^^^^^^
> 	     "$CONFIG_STATIC_MODULES" != "y" ]; then
> 	   define_bool CONFIG_STATIC_MODULES y
> 	fi

Hmmm, shouldn't it be written in CML2 if it is for 2.5 ?

For 2.4 the marked condition ( != n on a variable defined by dep_*)
probably would break xconfig. Don't suggest such solutions...

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
