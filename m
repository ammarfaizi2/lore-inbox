Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760585AbWLFNJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760585AbWLFNJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760584AbWLFNJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:09:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1818 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760585AbWLFNJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:09:58 -0500
Date: Wed, 6 Dec 2006 14:10:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
Message-ID: <20061206131003.GF24140@stusta.de>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com> <1165406299.3233.436.camel@laptopd505.fenrus.org> <1165407548.5954.224.camel@titan.tbdnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165407548.5954.224.camel@titan.tbdnetworks.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 01:19:08PM +0100, Norbert Kiesel wrote:
> On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
> > On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
> > > Hi,
> > > 
> > > I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
> > > be optimal for a machine with exactly 1GB memory (like my current
> > > desktop). Why is that option only prompted for after selecting EMBEDDED
> > > (which I normally don't select for desktop machines
> > 
> > because it changes the userspace ABI and has some other caveats.... this
> > is not something you should muck with lightly 
> > 
> 
> Hmm, but it's also marked EXPERIMENTAL. Would that not be the
> sufficient?  Assuming I don't use any external/binary drivers and a
> self-compiled kernel w//o any additional patches: is there really any
> downside?

- Wine doesn't work (I'm not sure about VMSPLIT_3G_OPT, but
                     VMSPLIT_2G definitely breaks Wine)
- AFAIR some people reported problems with some Java programs
  after fiddling with the vmsplit options

EMBEDDED isn't exactly the right way to hide it, but the vmsplit options 
aren't something you can safely change.

> </nk>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

