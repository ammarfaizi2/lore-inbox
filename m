Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTDYAub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTDYAua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:50:30 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:58613 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S262884AbTDYAuV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:50:21 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [Patch?] SiS 746 AGP-Support
Date: Fri, 25 Apr 2003 03:02:26 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200304250224.50431.volker.hemmann@heim9.tu-clausthal.de> <20030425004003.GA12614@suse.de>
In-Reply-To: <20030425004003.GA12614@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304250302.26791.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 April 2003 02:40, Dave Jones wrote:
>  > I don't know, if the following changes are 'clean' but they give me a
>  > working agpsupport for my SiS 746Fx based mobo.
>  >
>  > This (attempt) of a patch is against 2.4.21-rc1:
>
> Might work fine as long as you have an agp2.0 card in the slot, but the
> minute you put a 3.0 (read as AGPx8) card in there, things are very
> likely to break.
>
> I've not seen the specs for this chipset, but most of the AGP3 chipsets
> I've seen have a fallback mode in their register set which gets enabled
> as soon as you plug in an AGP2 card. These registers don't get enabled
> with an AGP3 card, instead you need to read from different registers,
> and in most cases, act completly different to decode aperture sizes etc.
>
> The generic routines in 2.5 *might* work, but are untested on this chipset.
> 2.4 currently has no AGP3 support at all. Some folks did backport what
> I've done in 2.5 a while ago, but I would advise against merging it at
> this stage, as there is still work to be done there, including stability
> fixes. Right there are a number of possible problems which may include
> random memory corruption.
>
> 		Dave

I have only a AGP 2 (geforce 4-mx) card, so I missed that(and with one I would 
only to be able to say 'it doesn't work' so thanks for your explanation). But 
without this changes I won't even able to use dga, because the first 
dga-enabled app completely locks up my box. 
And to have working AGP2 and non working APG3 looks a lot better for me than 
no AGP-support at all.  

2.5.* is able to 'mostly' boot on my mobo so I can't say anything about that..


Glück Auf,
Volker
