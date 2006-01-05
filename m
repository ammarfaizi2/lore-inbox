Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWAEOVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWAEOVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWAEOVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:21:31 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:48393 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751295AbWAEOV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:21:29 -0500
Date: Thu, 5 Jan 2006 15:21:20 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
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
Message-ID: <20060105142120.GA28611@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jaroslav Kysela <perex@suse.cz>,
	Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	ALSA development <alsa-devel@alsa-project.org>,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, LKML <linux-kernel@vger.kernel.org>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:23:23PM +0100, Jaroslav Kysela wrote:
> It means that you are saying that kernel should be bigger and bigger.
> Please, see the graphics APIs. Why we have X servers in user space (and
> only some supporting code is in the kernel) then? It's because if we 
> would move everything into kernel it will be even more bloated. The kernel 
> should do really the basic things like direct hardware access, DMA 
> transfer etc.

You plan to remove the network stack from the kernel when then?  X is
in user space for some rather strange values of userspace[1] for
historical and political reasons, not technical ones.  When
performance raises its ugly head and you end up having to listen to
engineers again you end up with DRI and that:

Module                  Size  Used by
nvidia               3464380  12 

X is a beautiful example of how things should not have been done.  Its
only redeeming quality is that it exists and works, and that's
definitively a non-negligible one.


> But it's a question, if OSS application developers take this proposal.

You seem to be missing the point that the entire reason why OSS is
important is that it isn't a library.

  OG.

[1] Direct hardware access, DMA, pci enumeration, hardware
    reconfiguration, what a beautiful userspace we have there.
