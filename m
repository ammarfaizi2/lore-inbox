Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933356AbWKNRM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbWKNRM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933458AbWKNRM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:12:27 -0500
Received: from atpro.com ([12.161.0.3]:24331 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S933356AbWKNRM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:12:26 -0500
Date: Tue, 14 Nov 2006 12:11:12 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <20061114171112.GM4824@voodoo.jdc.home>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <1163374762.5178.285.camel@gullible> <1163404727.15249.99.camel@laptopd505.fenrus.org> <1163443887.5313.27.camel@mindpipe> <1163449139.15249.197.camel@laptopd505.fenrus.org> <20061113221611.GG4824@voodoo.jdc.home> <1163489520.15249.233.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163489520.15249.233.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/06 08:32:00AM +0100, Arjan van de Ven wrote:
> On Mon, 2006-11-13 at 17:16 -0500, Jim Crilly wrote:
> > I know that Debian ships both because I have to switch back to the OSS
> > driver whenever I want to play one of those closed source games that mmap
> > /dev/dsp because the ALSA OSS emulation can't seem to handle having the
> > device opened via ALSA and /dev/dsp at the same time and the aoss wrapper
> > doesn't work for apps that use mmap on /dev/dsp.
> 
> and this is why shipping 2 drivers suck.
> "A has a bug so I need to use B" is the wrong answer, at least long
> term. The real answer is "fix A".
> I know it sucks for you, but if shipping B means A doesn't get fixed, or
> worse, bugs in A hardly get reported... it means the short term is
> hurting the long term, and just prolongs the pain even for you...
> (since switching drivers is a pain, and more and more stuff is depending
> on alsa nowadays)
> 

For the most part I agree and if the OSS emulation in ALSA was better I
would agree completely. But the fact that nothing can use /dev/dsp because
the device doesn't do hardware mixing and some apps are already using the
device via ALSA really sucks. Switching drivers is the least painful part
of the process, the real pain comes from having to kill all of the ALSA
apps to be able to use /dev/dsp in either case. I know that this has
been discussed before and no one has come up with a good way to make the
OSS emulation work with ALSA so I won't push the issue. And Doom3's last
patch did include ALSA support so maybe that's a sign that OSS is really
a thing of the past even in closed source apps.

Jim.
