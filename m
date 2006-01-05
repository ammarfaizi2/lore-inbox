Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWAEPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWAEPFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWAEPFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:05:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:52903 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750810AbWAEPFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:05:16 -0500
Subject: Re: [parisc-linux] Re: [OT] ALSA userspace API complexity
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: Jaroslav Kysela <perex@suse.cz>, zwane@commfireservices.com,
       ALSA development <alsa-devel@alsa-project.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, sailer@ife.ee.ethz.ch,
       kyle@parisc-linux.org, James@superbug.demon.co.uk,
       Thorsten Knabe <linux@thorsten-knabe.de>, linux-sound@vger.kernel.org,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Tomasz Torcz <zdzichu@irc.pl>, jgarzik@pobox.com, zab@zabbo.net,
       parisc-linux@lists.parisc-linux.org, Pete Zaitcev <zaitcev@redhat.com>
In-Reply-To: <20060105142120.GA28611@dspnet.fr.eu.org>
References: <20050726150837.GT3160@stusta.de>
	 <20060103193736.GG3831@stusta.de>
	 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
	 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
	 <20060104030034.6b780485.zaitcev@redhat.com>
	 <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
	 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
	 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
	 <20060105142120.GA28611@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Jan 2006 14:56:19 +0000
Message-Id: <1136472979.16358.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-05 at 15:21 +0100, Olivier Galibert wrote:
> historical and political reasons, not technical ones.  When
> performance raises its ugly head and you end up having to listen to
> engineers again you end up with DRI and that:
> 
> Module                  Size  Used by
> nvidia               3464380  12 

That isn't DRI. DRI is a good deal smaller than the crazy nvidia stuff.

radeon                 81089  1
drm                    83433  2 radeon

.. speaks volumes doesn't it 8)

> X is a beautiful example of how things should not have been done.  Its
> only redeeming quality is that it exists and works, and that's
> definitively a non-negligible one.

X servers have been implemented a variety of ways involving mixed user
and kernel space environments, user space only, pure kernel space, and
even downloading the server onto a graphics coprocessor and talking X
protocol to it.

The actual performance properties are heavily dependant upon the
architecture of the cards of the period. The flavour of the past few
years is the DMA command stream which happens to lend itself well to
splitting rendering between the kernel and user space. 

Alan

