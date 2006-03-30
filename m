Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWC3KMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWC3KMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWC3KMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:12:24 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:52165 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751151AbWC3KMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:12:23 -0500
Date: Thu, 30 Mar 2006 12:11:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       ashok.raj@intel.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       rjw@sisk.pl
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
In-Reply-To: <20060330030657.GA10405@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0603301208330.16802@scrub.home>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329161354.3ce3d71b.akpm@osdl.org>
 <200603301018.36654.ncunningham@cyclades.com> <200603301301.42922.ncunningham@cyclades.com>
 <20060330030657.GA10405@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 30 Mar 2006, Sam Ravnborg wrote:

> Roman is the one to addrress this.
> Roman?
> 
> On Thu, Mar 30, 2006 at 01:01:37PM +1000, Nigel Cunningham wrote:
> > Hi Sam.
> > 
> > A bunch of us were discussing an issue this morning, and came across the 
> > problem that selects don't seem to be enforced in choice menus. To give a 
> > concrete example, a couple of us tried to make CONFIG_SOFTWARE_SUSPEND select 
> > CONFIG_X86_GENERICARCH. After enabling SOFTWARE_SUSPEND, we want back to the 
> > subarchitecture menu, and could still select other subarches. Is this by 
> > design?

Yes, kconfig is supposed to be deterministic. Imagine two options each 
select a choice option, which would create an inconsistent configuration, 
so it's not allowed in first place.

bye, Roman
