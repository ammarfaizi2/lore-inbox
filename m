Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbUKIO15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUKIO15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUKIO14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:27:56 -0500
Received: from motgate8.mot.com ([129.188.136.8]:12981 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261516AbUKIO1y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:27:54 -0500
In-Reply-To: <Pine.GSO.4.61.0411091012550.25943@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0411091012550.25943@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <781C4866-325B-11D9-AD97-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Paul Mackerras" <paulus@samba.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux/PPC Development" <linuxppc-dev@ozlabs.org>,
       "Kumar Gala" <galak@somerset.sps.mot.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][PPC32] Add performance counters to cpu_spec
Date: Tue, 9 Nov 2004 08:27:22 -0600
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 9, 2004, at 3:13 AM, Geert Uytterhoeven wrote:

> On Mon, 8 Nov 2004, Kumar Gala wrote:
>  > Adds the number of performance monitor counters each PowerPC 
> processor has to
>  > the cpu table.  Makes oprofile support a bit cleaner since we dont 
> need a case
>  > statement on processor version to determine the number of counters.
>  >
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> >
> > --
>  >
> > diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
> > --- a/arch/ppc/kernel/cputable.c      2004-11-08 21:02:51 -06:00
>  > +++ b/arch/ppc/kernel/cputable.c      2004-11-08 21:02:51 -06:00
>  > @@ -82,6 +82,7 @@
>  >       CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
> >       COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
> >       32, 32,
>  > +     0,
>  >       __setup_cpu_601
> >      },
>  >      {        /* 603 */
>
> Perhaps you want to switch to C99-style struct initialization as well?

I can change it C99-style as well as fixing the formatting, just wanted 
to see if there we any other comments.  Will resend with those changes 
if I dont hear any other feedback.

- kumar

