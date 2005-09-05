Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVIEATb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVIEATb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVIEATb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:19:31 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:8066 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932239AbVIEATa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:19:30 -0400
Date: Mon, 5 Sep 2005 02:19:21 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       Domen Puncer <domen@coderock.org>
Message-ID: <20050905001921.GA20768@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Nish Aravamudan <nish.aravamudan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
	Domen Puncer <domen@coderock.org>
References: <20050904232259.777473000@abc> <20050904232337.296861000@abc> <29495f1d05090416453841f8d4@mail.gmail.com> <20050905000746.GA20663@linuxtv.org> <29495f1d05090417146fa89e54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05090417146fa89e54@mail.gmail.com>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: Re: [DVB patch 54/54] ttusb-budget: use time_after_eq()
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > On Sun, Sep 04, 2005 Nish Aravamudan wrote:
> > > On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > > >
> > > > -static int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
> > > > +static int numpkt = 0, numts, numstuff, numsec, numinvalid;
> > > > +static unsigned long lastj;
> > > >
> > >
> > > I think you actually want:
> > >
> > > static void ttusb_iso_irq(....)
> > > {
> > >      unsigned long lastj;
> > >
> > 
> > The code in question is used to print a one-per-second debug output,
> > and lastj is assigned after every print.
> 
> Ah yes, didn't see that in the current code, sorry for that noise.
> Still, lastj is local to ttusb_iso_irq(), right?

Yes, but it needs to be static.

Johannes
