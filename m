Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWADBsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWADBsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWADBsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:48:18 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:13327 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965149AbWADBsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:48:17 -0500
Date: Wed, 4 Jan 2006 02:48:15 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
Cc: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>, linux-kernel@vger.kernel.org,
       zaitcev@yahoo.com, zwane@commfireservices.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, jgarzik@pobox.com,
       parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org,
       zab@zabbo.net, linux-sound@vger.kernel.org, sailer@ife.ee.ethz.ch,
       James@superbug.demon.co.uk, alsa-devel@alsa-project.org, perex@suse.cz,
       Andi Kleen <ak@suse.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Tomasz Torcz <zdzichu@irc.pl>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104014814.GA64416@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Thomas Sailer <sailer@sailer.dynip.lugs.ch>,
	Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
	linux-kernel@vger.kernel.org, zaitcev@yahoo.com,
	zwane@commfireservices.com,
	Thorsten Knabe <linux@thorsten-knabe.de>, jgarzik@pobox.com,
	parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org,
	zab@zabbo.net, linux-sound@vger.kernel.org, sailer@ife.ee.ethz.ch,
	James@superbug.demon.co.uk, alsa-devel@alsa-project.org,
	perex@suse.cz, Andi Kleen <ak@suse.de>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Tomasz Torcz <zdzichu@irc.pl>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Adrian Bunk <bunk@stusta.de>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <1136334807.4106.51.camel@unreal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136334807.4106.51.camel@unreal>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 01:33:27AM +0100, Thomas Sailer wrote:
> On Wed, 2006-01-04 at 00:10 +0100, Tomasz K?oczko wrote:
> 
> > 1) ALSA API forces not use devices files and many things on sound managing
> >    level are handled on user space library. This dissallow civilized
> 
> Huh? Why's that? Actually, I welcome that ALSA does quite a lot in
> userspace, it could even do more. The whole format conversion and
> sampling rate conversion has no business in the kernel, IMO.

Doing things in userspace does not necessarily mean doing them in a
library, especially when it is required that the library be shared,
also known as "things _will_ break".

Especially since it tends to hide the real, user-accessible kernel
interface which has very, very annoying security implications.  At
that point, the ALSA kernel-userspace interface seems entirely
un-reviewed by the kernel people who have an eye for race conditions,
wandering userland pointers, information leaks, out-of-range accesses
and this kind of things (no patches from Al Viro on alsa?) and that
does not really give me a warm and fuzzy feeling.  And even if it is
reviewed at time t, it looks like it may change anytime a driver
author thinks it would help.  Not good at all.

  OG.

