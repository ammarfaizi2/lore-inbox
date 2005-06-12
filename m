Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVFLHl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVFLHl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 03:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVFLHl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 03:41:27 -0400
Received: from isilmar.linta.de ([213.239.214.66]:49381 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261907AbVFLHlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 03:41:23 -0400
Date: Sun, 12 Jun 2005 09:41:22 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA still advised as modules?
Message-ID: <20050612074122.GD15680@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Steve Snyder <swsnyder@insightbb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200506100811.17631.swsnyder@insightbb.com> <20050610122105.GA13931@isilmar.linta.de> <73AF5410-0EF8-4F1B-BE13-DB1F22B875DD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73AF5410-0EF8-4F1B-BE13-DB1F22B875DD@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 05:08:08PM -0400, Kyle Moffett wrote:
> On Jun 10, 2005, at 08:21:05, Dominik Brodowski wrote:
> >At least from 2.6.13 on, it will be much easier if you have the PCMCIA
> >"modules" built into the kernel, as you won't need userspace  
> >interaction any
> >longer (except on old yenta_socket bridges during startup, but  
> >that's a
> >different story). Therefore, I do not see any drawbacks to having  
> >the PCMCIA
> >modules built into the kernel.
> 
> Under such a setup, what is the easiest method to shut down the  
> bridge chip
> for power savings?  On my Debian laptop where said drivers are  
> modular, I can
> run "/etc/init.d/pcmcia stop" to unload the module and disable the  
> PCMCIA chip,
> saving a noticeable amount of power.  Is there some equivalent for  
> compiled-in
> drivers?  Thanks!

You can do "cardctl suspend" or (untested) echo "3" into the "power/state"
file of the relevant device inside the sysfs device tree ("/sys/devices/").

	Dominik
