Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTENKOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTENKOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:14:25 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:23560 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S261805AbTENKOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:14:22 -0400
Subject: Re: Improved DRM support for cant_use_aperture platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: davidm@hpl.hp.com, "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <20030514134141.A5170@jurassic.park.msu.ru>
References: <1052690133.10752.176.camel@thor>
	 <16063.60859.712283.537570@napali.hpl.hp.com>
	 <1052768911.10752.268.camel@thor>
	 <16064.453.497373.127754@napali.hpl.hp.com>
	 <1052774487.10750.294.camel@thor>
	 <16064.5964.342357.501507@napali.hpl.hp.com>
	 <1052786080.10763.310.camel@thor>
	 <16064.17852.647605.663544@napali.hpl.hp.com>
	 <20030513173347.A25865@jurassic.park.msu.ru>
	 <16065.6969.137647.391163@napali.hpl.hp.com>
	 <20030514134141.A5170@jurassic.park.msu.ru>
Content-Type: text/plain; charset=iso-8859-1
Organization: Debian, XFree86
Message-Id: <1052908024.18105.135.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 14 May 2003 12:27:05 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 2003-05-14 at 11:41, Ivan Kokshaysky wrote:
> On Tue, May 13, 2003 at 09:20:09AM -0700, David Mosberger wrote:
> 
> > What's the nature of those "ugly and fragile" hacks?  Are you saying
> > that CPU accesses to AGP space aren't remapped in the "normal" (PC)
> > way?  Or is it something entirely different?
> 
> Ok, you asked for it... :-)
> As you know, Alpha architecture is entirely cache coherent
> by design, i.e. there are no such things as non-cacheable mappings
> or cache flushing in hardware. Native Alpha Titan/Marvel AGP controllers
> are also cache coherent (kind of AGP extension of traditional
> Alpha PCI IOMMU).
> However, the "normal" PC AGP implementation isn't - this applies
> to AMD-751/761 AGP controllers on Nautilus as well.
> The AGP window on these chipsets is accessible by CPU *only* in the
> system memory address space, i.e. it's always cacheable and thus
> totally useless on Alpha.

Set cant_use_aperture and use David's patch then? :)


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

