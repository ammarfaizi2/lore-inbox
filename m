Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVJaHig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVJaHig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJaHig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:38:36 -0500
Received: from mx1.suse.de ([195.135.220.2]:8116 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932328AbVJaHig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:38:36 -0500
Date: Mon, 31 Oct 2005 08:38:34 +0100
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulus@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: add MODALIAS= for vio bus
Message-ID: <20051031073834.GA4868@suse.de>
References: <20051030213900.GA22510@suse.de> <20051031134814.42940751.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051031134814.42940751.sfr@canb.auug.org.au>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 31, Stephen Rothwell wrote:

> Hi Olaf,
> 
> This patch breaks lagacy iSeries i.e. it won't link (iSeries has no get_property()).
> It may be easier to redo this patch against Paulus' merge tree.

Can you fix it up, why is there no get_property for iseries, yet?
iseries_veth should be autoloaded in a similar way.
Maybe it should just go into a CONFIG_PSERIES or whatever.

> A couple of trivial comments:
> 
> On Sun, 30 Oct 2005 22:39:00 +0100 Olaf Hering <olh@suse.de> wrote:
> >
> > +static int pseries_vio_hotplug (struct device *dev, char **envp, int num_envp,
>                                  ^
> No space here, please.
> 
> > +	length = scnprintf (buffer, buffer_size, "MODALIAS=vio:T%sS%s",
>                           ^
> No space here either, please.

I copied it from macio_asic.c.


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
