Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271607AbTGQWdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271604AbTGQWcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:32:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58632 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271603AbTGQWcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:32:18 -0400
Date: Thu, 17 Jul 2003 18:39:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Schlemmer <azarah@gentoo.org>
cc: Mark Watts <m.watts@eris.qinetiq.com>, KML <linux-kernel@vger.kernel.org>
Subject: Re: devfsd/2.6.0-test1
In-Reply-To: <1058443807.13515.1530.camel@workshop.saharacpt.lan>
Message-ID: <Pine.LNX.3.96.1030717183139.17023B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2003, Martin Schlemmer wrote:

> On Thu, 2003-07-17 at 11:17, Mark Watts wrote:

> > I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new kernel)
> > 
> > Every time I boot, it complains that I don't have an /etc/modprobe.devfs.
> > If I symlink modules.devfs, I get a wad of errors about 'probeall'.
> > What should a modprobe.devfs look like for a 2.5/6 kernel?
> > 
> 
> The module-init-tools tarball should include one.

Agreed, it should. However, the last version I pulled had zero support for
probeall, and more importantly for probe, which is somewhat harder to do
cleanly without having to rewrite the config file for each kernel you
boot.

I assume someone will need to write a functional config parser which
handles these features before 2.6 is seriously ready for production.
Giving up the ability to find the working module for a device would be a
step back, and is needed to allow booting with changing configurations,
such as docked or not laptops, PCMCIA cards inserted, various hardware
such as printers and scanners attached, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

