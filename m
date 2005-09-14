Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbVINUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbVINUza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbVINUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:55:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27270 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932731AbVINUz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:55:29 -0400
Date: Wed, 14 Sep 2005 22:54:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan De Luyck <lkml@kcore.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: ACPI S3 and ieee1394 don't get along
Message-ID: <20050914205432.GA3460@elf.ucw.cz>
References: <200509131156.31914.lkml@kcore.org> <43276C2D.2000901@s5r6.in-berlin.de> <200509140708.12281.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509140708.12281.lkml@kcore.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > after putting my laptop into S3 and reviving it at home, the firewire
> > > interface was unusable, no response when plugging in my external disk,
> > > loading sbp2 manually didn't trigger anything.
> >
> > [...]
> >
> > > I saw this thread:
> > > http://marc.theaimsgroup.com/?l=linux1394-user&m=111262313930798&w=2
> > > tho I'm not sure if it's relevant to this.
> >
> > IEEE 1394 power management (i.e. management of bus power consumption or
> > of other nodes' internal power states) is not related to ACPI suspend/
> > resume of the local controller AFAICS.
> 
> I thought so. It was the only thing even remotely relevant I found on the mailinglists tho.
> 
> > According to your log, the cause is to be looked for in ohci1394's
> > purely hardware related parts or perhaps even outside of the ieee1394
> > subsystem.
> 
> I've attached the lspci -vvx before and after suspending to S3. There are a lot of differences, 
> but I have no idea how to interprete them :/

pci_save_state/pci_restore_state missing somewhere?
									Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
