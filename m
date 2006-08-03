Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWHCODN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWHCODN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWHCODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:03:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:33440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932494AbWHCODL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:03:11 -0400
X-Authenticated: #428038
Date: Thu, 3 Aug 2006 16:03:07 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Ric Wheeler <ric@emc.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060803140307.GB7431@merlin.emma.line.org>
Mail-Followup-To: Ric Wheeler <ric@emc.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
	reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
	rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
	lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
	linux-kernel@vger.kernel.org
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF9BAD.5020003@emc.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006, Ric Wheeler wrote:

> Mirroring a corrupt file system to a remote data center will mirror your 
> corruption.
> 
> Rolling back to a snapshot typically only happens when you notice a 
> corruption which can go undetected for quite a while, so even that will 
> benefit from having "reliability" baked into the file system (i.e., it 
> should grumble about corruption to let you know that you need to roll 
> back or fsck or whatever).
> 
> An even larger issue is that our tools, like fsck, which are used to 
> uncover these silent corruptions need to scale up to the point that they 
> can uncover issues in minutes instead of days.  A lot of the focus at 
> the file system workshop was around how to dramatically reduce the 
> repair time of file systems.

Which makes me wonder if backup systems shouldn't help with this. If
they are reading the whole file anyways, they can easily compute strong
checksums as they go, and record them for later use, and check so many
percent of unchanged files every day to complain about corruptions.

-- 
Matthias Andree
