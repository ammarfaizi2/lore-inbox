Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265688AbRGCRkD>; Tue, 3 Jul 2001 13:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265545AbRGCRjx>; Tue, 3 Jul 2001 13:39:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15275 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265478AbRGCRji>;
	Tue, 3 Jul 2001 13:39:38 -0400
Message-ID: <3B420356.660F5CC8@mandrakesoft.com>
Date: Tue, 03 Jul 2001 13:39:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: kaos@ocs.com.au, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
In-Reply-To: <200107031735.TAA00455@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> >
> > A couple things that would be nice for 2.5 is
> > - let MOD_INC_USE_COUNT work even when module is built into kernel, and
> > - let THIS_MODULE exist and be valid even when module is built into
> > kernel
> >
> > This introduces bloat into the static kernel for modules which do not
> > take advantage of this, so perhaps we can make this new behavior
> > conditional on CONFIG_xxx option.  Individual drivers which make use of
> > the behavior can do something like
> >
> >       dep_tristate 'my driver' CONFIG_MYDRIVER $CONFIG_PCI
> >       if [ "$CONFIG_MYDRIVER" != "n" -a \
>               ^^^^^^^^^^^^^^^^^^^^^^^
> >            "$CONFIG_STATIC_MODULES" != "y" ]; then
> >          define_bool CONFIG_STATIC_MODULES y
> >       fi
> 
> Hmmm, shouldn't it be written in CML2 if it is for 2.5 ?

no comment


> For 2.4 the marked condition ( != n on a variable defined by dep_*)
> probably would break xconfig. Don't suggest such solutions...

why is != n on a variable defined by dep_xx bad?
That doesn't make sense.

	Jeff


-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
