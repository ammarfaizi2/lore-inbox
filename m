Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWAETTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWAETTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWAETTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:19:54 -0500
Received: from affenbande.org ([81.169.150.36]:48008 "EHLO
	tarzan.affenbande.org") by vger.kernel.org with ESMTP
	id S1750948AbWAETTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:19:53 -0500
Date: Thu, 5 Jan 2006 20:15:51 +0100
From: Florian Schmidt <tapas@affenbande.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <tapas@affenbande.org>,
       Tomasz =?ISO-8859-1?Q?K=B3oczk?= =?ISO-8859-1?Q?o?= 
	<kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060105201551.3a88fb0b@mango.fruits.de>
In-Reply-To: <1136486180.31583.29.camel@mindpipe>
References: <s5h1wzpnjrx.wl%tiwai@suse.de>
	<20060103203732.GF5262@irc.pl>
	<s5hvex1m472.wl%tiwai@suse.de>
	<9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	<20060103215654.GH3831@stusta.de>
	<20060103221314.GB23175@irc.pl>
	<20060103231009.GI3831@stusta.de>
	<Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	<20060104000344.GJ3831@stusta.de>
	<Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	<20060104010123.GK3831@stusta.de>
	<Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
	<20060104113726.3bd7a649@mango.fruits.de>
	<1136445395.24475.17.camel@mindpipe>
	<20060105124317.2d12a85c@mango.fruits.de>
	<1136486180.31583.29.camel@mindpipe>
Organization: affenbande
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 13:36:20 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> OK so you can contrive an example.  Have we ever seen a real world app
> where aoss can't work?

Well, until i provided my hacky and probably buggy patch to aoss to use
libc's fopen()-et. al.-hooks, no app using the OSS api by way of libc's
fopen() et. al. was able to use aoss.  I don't use aoss anymore, as i
have hw mixing, so i haven't really done anymore testing. I admit of not
being sure, whether this principle error has any realistic impact (i.e.
apps/libs exist that resolve their system call symbols at build time - i
must also admit that i don't have really complete understanding of this
issue. maybe a more knowledgable person can speak up about possible use
scenarios besides libc). 

> > Errm, i'm actually wrong about that. Kernel level OSS emu sw mixing
> > cannot work together with userspace ALSA sw mixing. I completely missed
> > that point.
> > 
> > I still think, the easiest way would be to use FUSE as it gives the best
> > of both worlds:
> 
> Yep, this does sound like a promising approach.  AFAIK it's never been
> seriously explored as FUSE is so new.

Plus, i was wrong :) FUSE is for filesystems. fusd would be the choice
for this (not included in kernel yet). One might see how far one gets
with reusing code from both aoss and oss2jack

http://fort.xdas.com/~kor/oss2jack/

Btw: It has a nice list of compatible apps including skype and quake3
;)

Btw2: Heh, oss2jack already has direct ALSA support on its TODO list :)

fusd:

http://www.circlemud.org/%7Ejelson/software/fusd/

Regards,
Flo
