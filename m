Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWAWNNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWAWNNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWAWNNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:13:17 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:4345 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751423AbWAWNNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:13:16 -0500
Date: Mon, 23 Jan 2006 08:12:51 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly	different	approach
In-reply-to: <s5hd5ijyw2q.wl%tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linuxppc-dev@ozlabs.org
Message-id: <1138021971.22672.65.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060119174600.GT19398@stusta.de>
 <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
 <20060120212917.GA14405@suse.de>
 <1137799001.12998.59.camel@localhost.localdomain>
 <1137799330.13530.30.camel@grayson> <s5hd5ijyw2q.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 13:20 +0100, Takashi Iwai wrote:
> > > > > Can someone from the ppc developers drop me a small note whether 
> > > > > SND_POWERMAC completely replaces DMASOUND_PMAC?
> > > > 
> > > > It doesnt. Some tumbler models work only after one plug/unplug cycle of
> > > > the headphone. early powerbooks report/handle the mute settings
> > > > incorrectly. there are likely more bugs.
> > > 
> > > Interesting... Ben Collins hacked something to have Toonie work as a
> > > "default" driver for non supported machine and saw that problem too, I
> > > think he fixes it, I'll check with him what's up there and if his fix
> > > applied to tumbler.c as well.
> > 
> > My "fix" was basically the result of converting to the platform
> > functions. It's hit or miss whether this works with tumbler too.
> > 
> > You can try the Ubuntu kernel packages (they can be unpacked and used on
> > non Ubuntu systems pretty easily) to see if it works for you. Tumbler
> > platform function conversion isn't even tested, so I'd be happy to hear
> > any feedback.
> 
> Don't forget to forward your patches to alsa-devel or me ;)

I'm passing everything through to BenH, especially since it's all using
functions new in his ppc tree.

Update on this "fix", it worked only because platform function
interrupts weren't enabled. Now that they are, it's back to the same old
thing.

At least that's a clue, though.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

