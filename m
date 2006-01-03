Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWACRSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWACRSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWACRSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:18:13 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:19635 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932458AbWACRSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:18:12 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Tue, 3 Jan 2006 17:16:13 +0000
User-Agent: KMail/1.9
Cc: Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org>
In-Reply-To: <20060103170316.GA12249@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031716.13409.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 17:03, Olivier Galibert wrote:
> On Tue, Jan 03, 2006 at 04:29:21PM +0000, Alistair John Strachan wrote:
> > This has nothing to do with the kernel option CONFIG_SND_OSSEMUL which
> > Jan referred to, and to which I was responding. "aoss" is also not
> > compatible with every conceivable program.
>
> Especially not with plugins.  Flashplayer anybody?

Konqueror manages to "wrap" plugins quite happily.. complain to whoever makes 
your browser.

> > This is exactly why the OSS emulation option in ALSA is really a last
> > resort and should not be an excuse for people to ignore implementing ALSA
> > support directly. More so, it is very good justification for ditching
> > "everything OSS" as soon as possible, at least in new software.
>
> Actually the crappy state of OSS emulation is a good reason to ditch
> ALSA in its current implementation.  As Linus reminded not so long
> ago, backwards compatibility is extremely important.

This argument is basically watered down with devfs, udev, sysfs, etc. which 
all have exactly the same issues. Should a crippled OSS API be the way 
forward for Linux? I think not.
 
> Also, not everybody wants to depend on a shared library.  I find this
> "the alsa lib must be kept in lockstep with the kernel version" quite
> annoying.  I'd rather not have the windows dll hell on linux, TYVM.
> Or in other words, the public API of a kernel interface should _NEVER_
> be a library only.  At least OSS, with all its issues, had that right.

Okay, I agree it's not ideal. But if you want software mixing, and it's a 
genuinely useful feature, you either have to go down the road of running some 
crappy daemon like arts or esound, or just link against libasound and get it 
for free. I know I'd rather not have mixing routines in my kernel, thanks.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
