Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273288AbTHRQrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274813AbTHRQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:47:45 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:4339
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S273288AbTHRQrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:47:37 -0400
Date: Mon, 18 Aug 2003 18:51:02 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Tom Sightler <ttsig@tuxyturvy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O16.2int
Message-ID: <20030818165102.GB7570@wind.cocodriloo.com>
References: <1061152667.5526.26.camel@athxp.bwlinux.de> <1061156820.1775.32.camel@iso-8590-lx.zeusinc.com> <1061169664.3f402a00ae7b6@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061169664.3f402a00ae7b6@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 11:21:04AM +1000, Con Kolivas wrote:
> Quoting Tom Sightler <ttsig@tuxyturvy.com>:
> 
> > Hi Con,
> 
> Hi Tom
> 
> > 1. -- Wine running Windows Media Player 6.4 works great when running in
> 
> Yes a well known problem now (see other threads about wine). Wine doing 
> something very cpu intensive exhibits this due to a combination of wine 
> breakage brought out by my scheduler tweaks causing priority inversion.
> 
> > 2. -- Adobe Acrobat 5.07 for Linux seems to have a very similar issue, a
> > large complex document seems to starve out the whole system making the
> > system feel locked up for several seconds.
> 
> Actually I've profiled acroread and it seems to be more a memory issue than a 
> scheduler one per se. Something very inefficient about it's design and it 
> behaves much worse as a mozilla plugin than standalone. Give it lots of cpu 
> time and it just keeps doing more and more vm work.

Acrobat has a switch so that it keeps a cache of rendered pages, and
obviously it default to ON, so just reading a big PDF file page by
page will trash all the system with lots useless data. BUT, for simple
PDF usage in a non-multitasking single-user machine it's faster
so there you have a possible reason for it's strange behaviour.

 
> > 3. -- It seems I can trigger the same kind of starvation by simply doing
> > large selects in a Konsole window.  Selecting a large section of text
> 
> > Konsole issue, however, if another application is using a reasonable
> > amount of CPU, say a video playing in Wine using ~50% CPU, then it seems
> > easy to make this happen.  Once it happens it's very hard to recover,
> 
> This is because of wine, not the Konsole which behaves fine, but tips the 
> combination of wine and something else over the edge.
> 
> I'm working on it. Thanks very much for your report.
> 
> Cheers,
> Con
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
