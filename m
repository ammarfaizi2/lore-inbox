Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWEAQ4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWEAQ4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWEAQ4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:56:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:54253 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932151AbWEAQ4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:56:21 -0400
Date: Mon, 1 May 2006 09:54:43 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tiwai@suse.de,
       henne@nachtwindheim.de
Subject: Re: [ALSA] add __devinitdata to all pci_device_id
Message-ID: <20060501165443.GA9441@kroah.com>
References: <200605011511.k41FBUcu025025@hera.kernel.org> <1146502164.20760.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146502164.20760.53.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 06:49:24PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-05-01 at 15:11 +0000, Linux Kernel Mailing List wrote:
> > commit 396c9b928d5c24775846a161a8191dcc1ea4971f
> > tree 447f4b28c2dd8e0026b96025fb94dbc654d6cade
> > parent 71b2ccc3a2fd6c27e3cd9b4239670005978e94ce
> > author Henrik Kretzschmar <henne@nachtwindheim.de> Mon, 24 Apr 2006 15:59:04 +0200
> > committer Jaroslav Kysela <perex@suse.cz> Thu, 27 Apr 2006 21:10:34 +0200
> > 
> > [ALSA] add __devinitdata to all pci_device_id
> 
> 
> are you really really sure you want to do this?
> These structures are exported via sysfs for example, I would think this
> is quite the wrong thing to make go away silently...

I asked Henrik to not do this, but oh well...

No, if they are marked __devinit, and CONFIG_HOTPLUG is enabled, then
the sysfs stuff is enabled.  And since CONFIG_HOTPLUG is pretty much
always enabled these days, the savings of this kind of patch is
non-existant...

greg k-h
