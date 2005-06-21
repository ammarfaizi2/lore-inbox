Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVFUQ4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVFUQ4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFUQ4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:56:23 -0400
Received: from isilmar.linta.de ([213.239.214.66]:25787 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262171AbVFUQxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:53:06 -0400
Date: Tue, 21 Jun 2005 18:53:03 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: Bug in pcmcia-core
Message-ID: <20050621165303.GA14487@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Lee Revell <rlrevell@joe-job.com>,
	James Courtier-Dutton <James@superbug.demon.co.uk>,
	Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
References: <42B1FF2A.2080608@superbug.demon.co.uk> <20050617014820.GA15045@animx.eu.org> <42B27D51.4040407@superbug.demon.co.uk> <1119368594.19357.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119368594.19357.22.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 21, 2005 at 11:43:14AM -0400, Lee Revell wrote:
> On Fri, 2005-06-17 at 08:35 +0100, James Courtier-Dutton wrote:
> > > I thought drivers for the cardbus cards were the same as standard PCI cards. 
> > > I know that as far as networking goes, the same driver runs a cardbus 3com
> > > 3c575 and the pci 3c905.  Same with netgear's cardbus FA510 and PCI FA310.
> > > 
> > > I'm not a kernel developer, but this is what I've understood.
> > > 
> > 
> > That is also what I thought. But I think that the cardbus 3com 3c575
> > uses memory for io and not ioports. I think the problem is related to
> > the use of ioports on an cardbus card.
> 
> Any update on this?  Is the PCMCIA layer really unmaintained?  Are we
> hosed?

Check the linux-pcmcia list, check -mm and you'll see that the PCMCIA layer
is in the process of being updated.

> A quick grep of the subjects in my LKML folder for "PCMCIA" is certainly
> not encouraging.  I see lots of questions along the lines of "did ANYONE
> EVER get this to work?" with no replies...

Well, some of them are handled in the background, some are simply unsolvable
(no real reason for hardware to behave the way it does, no driver support,
extremely strange setups, ...), some bugs are caused elsewhere (e.g., in
current -mm, PCI makes life difficult for PCMCIA), and some bugs are not
handled at all because the few developers taking care of PCMCIA do have too
few time. So, some help in maintaining PCMCIA is much appreciated.

	Dominik
