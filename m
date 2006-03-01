Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWCANeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWCANeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWCANeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:34:44 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:52152 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750798AbWCANen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:34:43 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Maule <maule@sgi.com>, akpm@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
References: <20060214162337.GA16954@sgi.com>
	<20060220201713.GA4992@infradead.org> <20060221024710.GB30226@sgi.com>
	<20060221103633.GA19349@infradead.org>
	<yq0r75x6jmn.fsf@jaguar.mkp.net>
	<20060225115512.GA24439@infradead.org>
From: Jes Sorensen <jes@sgi.com>
Date: 01 Mar 2006 08:34:41 -0500
In-Reply-To: <20060225115512.GA24439@infradead.org>
Message-ID: <yq0hd6i70ge.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Tue, Feb 21, 2006 at 06:23:12AM -0500, Jes Sorensen
Christoph> wrote:
>> Point is that there are cases where tuning requires you to know
>> what PCI bridge is below you in order to get the best performance
>> out of a card. One can keep a PCI ID blacklist to handle tuning of
>> the PCI bridge itself, but it can't handle things that needs to be
>> tuned by setting the PCI device's own registers.
>> 
>> Having a generic API to export this information would be a good
>> thing IMHO.

Christoph> So please submit a patch to add querying/tuning pci
Christoph> bridges.  And please make it _GPL exports so people don't
Christoph> accidentally use it in their illegal drivers.

Mark checked with the gfx people and it seems that the requirement for
this information was a leftover from an older codebase and they don't
actually need it anymore. Anyway, I'm not sure what illegal drivers
you keep referring to.

Tony/Andrew, it should be ok to take the export out again.

I'll try to look into doing a more generic interface for querying
information about the low level PCI briges at some point. Since
there's no new users screaming for this right now and most current
drivers that will benefit from it are somewhat old, it's not going to
be my top priority item at this moment. Since this would be an
interface, it would obviously have to a regular symbol export.

Cheers,
Jes
