Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVIEIpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVIEIpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVIEIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:45:22 -0400
Received: from lidskialf.net ([62.3.233.115]:41896 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S932340AbVIEIpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:45:20 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: nish.aravamudan@gmail.com
Subject: Re: [DVB patch 14/54] frontend: s5h1420: fixes
Date: Mon, 5 Sep 2005 09:45:04 +0100
User-Agent: KMail/1.8.2
Cc: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050904232259.777473000@abc> <20050904232321.306762000@abc> <29495f1d0509041656261f8a33@mail.gmail.com>
In-Reply-To: <29495f1d0509041656261f8a33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509050945.04211.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 Sep 2005 00:56, Nish Aravamudan wrote:
> On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > From: Andrew de Quincey <adq_dvb@lidskialf.net>
> >
> > Misc. fixes.
>
> <snip>
>
> > --- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/s5h1420.c       
> > 2005-09-04 22:24:24.000000000 +0200 +++
> > linux-2.6.13-git4/drivers/media/dvb/frontends/s5h1420.c     2005-09-04
> > 22:28:04.000000000 +0200
>
> @@ -138,16 +146,17 @@ static int s5h1420_send_master_cmd (stru
>
> <snip>
>
> >         /* wait for transmission to complete */
> >         timeout = jiffies + ((100*HZ) / 1000);
>
> <snip>
>
> > @@ -236,7 +246,7 @@ static int s5h1420_send_burst (struct dv
> >         s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) |
> > 0x08);
> >
> >         /* wait for transmission to complete */
> > -       timeout = jiffies + ((20*HZ) / 1000);
> > +       timeout = jiffies + ((100*HZ) / 1000);
>
> Should these be
>
> timeout = jiffies + msecs_to_jiffies(100);

Yes, you're right.
