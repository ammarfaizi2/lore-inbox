Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWACU4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWACU4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWACU4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:56:33 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:1817 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932506AbWACU4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:56:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oGWlG6GA/ByHgexwqoFyrStH2CFo4K0wJ50ULsyt+42wrjmAU6ag9FdtpyRnrOZhn2hld6OhMFC37VrOvFkioszBBAzplr5LOf724tlPvfLPrIxtkN5KvziLrQamGnpNZLWGzD4vB/2cpBAYUKr3bMOuNUvwkRQDakB5/Imexck=
Message-ID: <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
Date: Tue, 3 Jan 2006 21:56:20 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Cc: Tomasz Torcz <zdzichu@irc.pl>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hvex1m472.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk>
	 <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org>
	 <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
	 <s5hvex1m472.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 3 Jan 2006 21:37:32 +0100,
> Tomasz Torcz wrote:
> >
> > On Tue, Jan 03, 2006 at 09:22:58PM +0100, Takashi Iwai wrote:
> > > At Tue, 3 Jan 2006 18:03:16 +0100,
> > > Olivier Galibert wrote:
> > > >
> > > > > This is exactly why the OSS emulation option in ALSA is really a last resort
> > > > > and should not be an excuse for people to ignore implementing ALSA support
> > > > > directly. More so, it is very good justification for ditching "everything
> > > > > OSS" as soon as possible, at least in new software.
> > > >
> > > > Actually the crappy state of OSS emulation is a good reason to ditch
> > > > ALSA in its current implementation.  As Linus reminded not so long
> > > > ago, backwards compatibility is extremely important.
> > >
> > > Well, we keep the compatibility exactly -- OSS drivers don't support
> > > software mixing in the kernel, too :)
> >
> >  OSS will support software mixing. In kernel. On NetBSD.
> > http://kerneltrap.org/node/4388
>
> Why do we need to keep the compatibility with NetBSD?
>
Software mixing is a really nice feature for people with soundscards
that can't do hardware mixing, so if the OSS compatibility could
transparently do software mixing for apps using OSS api that would be
a very nice extension for a lot of people - I'd say that if NetBSD do
that they've got the right idea.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
