Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWAFKet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWAFKet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWAFKet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:34:49 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:64461 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932199AbWAFKes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:34:48 -0500
Date: Fri, 6 Jan 2006 11:34:37 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Marcin Dalecki <martin@dalecki.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060106103436.GB24929@boogie.lpds.sztaki.hu>
References: <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <1136491503.847.0.camel@mindpipe> <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de> <1136493172.847.26.camel@mindpipe> <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de> <9a8748490601051535s5e28fd81of6814088db7ccac@mail.gmail.com> <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de> <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 03:36:47AM +0200, Hannu Savolainen wrote:

> There are two very opposite approaches to do a sound subsystem. The ALSA 
> way is to expose every single detail of the hardware to the applications 
> and to allow (or force) application developers to deal with them. The OSS 
> approach is to provide maximum device abstraction in the API level (by 
> isolating the apps from the hardware as much as practically possible).

Well, then it is quite clear to me: you can build an OSS-like interface
on top of ALSA, but you cannot build an ALSA-like interface on top of
OSS. This implies that an ALSA-like interface should be in the kernel,
and an OSS-like interface should be implemented on top of it in
userspace for those who do not need all the features. This way both
camps are satisfied.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
