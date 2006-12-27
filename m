Return-Path: <linux-kernel-owner+w=401wt.eu-S1754777AbWL0Xox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbWL0Xox (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 18:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWL0Xox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 18:44:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:60202 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbWL0Xow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 18:44:52 -0500
X-Originating-Ip: 74.109.98.100
Date: Wed, 27 Dec 2006 18:38:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200612271303.kBRD3tSJ007866@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.64.0612270924530.3691@localhost.localdomain>
References: <200612271303.kBRD3tSJ007866@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Subject: Re: [PATCH] Remove logically superfluous comparisons from Kconfig files.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Dec 2006, Horst H. von Brand wrote:

> Robert P. J. Day <rpjday@mindspring.com> wrote:
> >   Remove Kconfig comparisons of the form FUBAR || FUBAR=n, since they
> > appear to be superfluous.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> >
> > ---
> >
> >   based on what i read in kconfig-language.txt, it would *appear* that
> > those comparisons are redundant, but i'm willing to be convinced
> > otherwise.  (unless the developer specifically wanted the case of
> > "!=m", which i'm fairly sure is not the same thing, yes?)
>
> Would be clearer written that way if so.
>
> >  drivers/char/drm/Kconfig   |    2 +-
> >  fs/dlm/Kconfig             |    1 -
> >  net/ipv4/netfilter/Kconfig |    1 -
> >  net/sctp/Kconfig           |    1 -
> >  4 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
> > index ef833a1..d681e68 100644
> > --- a/drivers/char/drm/Kconfig
> > +++ b/drivers/char/drm/Kconfig
> > @@ -6,7 +6,7 @@
> >  #
> >  config DRM
> >  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
> > -	depends on (AGP || AGP=n) && PCI
> > +	depends on && PCI
>                    ^^ ???

the stuff above is *very* old and also incorrect -- the only
outstanding patch i have in the queue should be to remove the final 3
"depends" directives in Kconfig files, nothing more.

rday
