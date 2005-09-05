Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVIEANo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVIEANo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVIEANo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:13:44 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:6018 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932233AbVIEANn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:13:43 -0400
Date: Mon, 5 Sep 2005 02:13:36 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Oliver Endriss <o.endriss@gmx.de>, Patrick Boettcher <pb@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Message-ID: <20050905001336.GB20663@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Nish Aravamudan <nish.aravamudan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Oliver Endriss <o.endriss@gmx.de>,
	Patrick Boettcher <pb@linuxtv.org>,
	Andrew de Quincey <adq_dvb@lidskialf.net>
References: <20050904232259.777473000@abc> <20050904232336.080662000@abc> <29495f1d05090416413caf9043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05090416413caf9043@mail.gmail.com>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: Re: [DVB patch 51/54] ttpci: av7110: RC5+ remote control support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > --- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_ir.c  2005-09-04 22:03:40.000000000 +0200
> > +++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_ir.c       2005-09-04 22:31:00.000000000 +0200
> > @@ -7,16 +7,16 @@
> >  #include <asm/bitops.h>
> > 
> >  #include "av7110.h"
> > +#include "av7110_hw.h"
> > 
> > -#define UP_TIMEOUT (HZ/4)
> > +#define UP_TIMEOUT (HZ*7/25)
> 
> Should this be
> 
> #define UP_TIMEOUT msecs_to_jiffies(280)
> 
> or
> 
> #define UP_TIMEOUT (7*msecs_to_jiffies(40)
> 
> ?

I agree it's nicer to read, but AFAIK not required for correctness?
If so, then we'll fix those up in linuxtv.org CVS and submit
cleanup patches later.

Thanks for your comments.

Johannes
