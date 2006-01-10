Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWAJJyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWAJJyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWAJJyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:54:40 -0500
Received: from gate.perex.cz ([85.132.177.35]:56723 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750891AbWAJJyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:54:38 -0500
Date: Tue, 10 Jan 2006 10:54:32 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Hannu Savolainen <hannu@opensound.com>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>,
       Olivier Galibert <galibert@pobox.com>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601060348380.29362@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.61.0601101048360.10330@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
 <43BDA02F.5070103@folkwang-hochschule.de> <20060105234951.GA10167@dspnet.fr.eu.org>
 <43BDB858.5060500@folkwang-hochschule.de> <Pine.LNX.4.61.0601060348380.29362@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Hannu Savolainen wrote:

> What happens if some system load peak delays the application by 20 ms? The 
> result is complete failure. What is the ALSA (API) feature OSS doesn't 
> have that makes it able to predict what kind of output the application 
> should have fed to the device during the (about) 20 ms period of silence? 
> 
> The fact is that there is nothing the audio subsystem can do to recover 
> the situation. For this very simple reason the OSS API lacks everything 
> that would be necessary to cope with this kind of problems.

Applications should be notified that something is broken. If you have
a professional environment, you really need to know, if the output 
survived all scheduling peaks and the audio data are delivered from/to
I/O in time.

Also, in the standard consumer environment is good to know that the system
have some trouble to deliver data in time (motivating developers of core 
Linux kernel code or subsystems, or motivating app programers to set the 
correct scheduling parameters) to fix remaining problems.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
