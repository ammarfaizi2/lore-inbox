Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVLEVxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVLEVxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVLEVxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:53:31 -0500
Received: from torrent.CC.McGill.CA ([132.206.27.49]:57499 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S964804AbVLEVxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:53:31 -0500
Subject: Re: echo "mem" > /sys/power/state fails
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: Pavel Machek <pavel@ucw.cz>
Cc: David.Ronis@mcgill.ca, linux-kernel@vger.kernel.org
In-Reply-To: <20051205211232.GA1728@elf.ucw.cz>
References: <1133742700.6492.3.camel@montroll.chem.mcgill.ca>
	 <20051205211232.GA1728@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Chemistry, McGill University
Date: Mon, 05 Dec 2005 16:52:58 -0500
Message-Id: <1133819578.5960.42.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.  Unfortunately that isn't an option for me (unless
2.6.12.6 supports it, which I don't think it does); the 2.6.1[34] series
are badly broken on this box; disk response is x100 slower.  The problem
seems to be in the acpi subsystem, but I'm not sure.  It's been reported
on this list, on the linux-ide list and most recently at
bugzilla.kernel.org [Bug 5594]; so far nobody has come up with a
workable fix or diagnosis (there was a suggestion about the default IRQ
used for ide, but I couldn't find where that was set in the kernel [I've
never hacked the kernel]).

David



On Mon, 2005-12-05 at 22:12 +0100, Pavel Machek wrote:
> On Ne 04-12-05 19:31:40, David Ronis wrote:
> > I've got a HP laptop (a Pavilion ZV5240CA) running a 2.6.12.6 kernel.
> > This as a pentium 4 hyperthreaded chip.
> > 
> > cat /sys/power/state gives:  standby mem disk 
> > 
> > echo mem > /sys/power/state as root does nothing.  Nothing appears in
> > the logs either.
> > 
> > Any suggestions?
> 
> Try any reasonably new kernel, with cpu hotplug enabled.
> 

