Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272622AbTHKOrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272697AbTHKOqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:46:42 -0400
Received: from www.13thfloor.at ([212.16.59.250]:41659 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272670AbTHKOm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:42:58 -0400
Date: Mon, 11 Aug 2003 16:42:42 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Flameeyes <daps_mls@libero.it>
Cc: Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811144242.GE4562@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Flameeyes <daps_mls@libero.it>,
	Pavel Machek <pavel@suse.cz>,
	Christoph Bartelmus <columbus@hit.handshake.de>,
	LIRC list <lirc-list@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <1060607466.5035.8.camel@defiant.flameeyes>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1060607466.5035.8.camel@defiant.flameeyes>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 03:11:07PM +0200, Flameeyes wrote:
> On Mon, 2003-08-11 at 14:47, Pavel Machek wrote:
> > I converted lirc_gpio into input/ layer (and killed support for
> > hardware I do not have; sorry but it was essential to keep code
> > small). Ported driver looks like this; I believe it looks better than
> > old code. Patch is here.
> You can here see the problem... not all tv cards use the same remote,
> the switch doesn't work with my remote for example, so we have 2
> possibilities:
> 
> a) hardcode all the possible remotes adding these as new one come up,
> this is a big work in the kernel source, and also we lost compatibility
> with remotes that use the same frequency of the ones with the tv card,
> and that now can be used.
> 
> b) create an userspace utility that read the input layer for codes an
> then translates them in user-definable commands. This is what lircd do
> now...

what about 
  
  c) hardcode the basic decoding and use a mapping table
     which can be configure from userspace ...
     (like dvbs haupauge or xmodmap)

best,
Herbert

> IMHO, the solution used now is the more flexible of the two.
> -- 
> Flameeyes <dgp85@users.sf.net>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
