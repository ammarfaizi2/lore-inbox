Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUFLBXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUFLBXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 21:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUFLBXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 21:23:40 -0400
Received: from gate.ebshome.net ([66.92.248.57]:4844 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S264515AbUFLBXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 21:23:38 -0400
Date: Fri, 11 Jun 2004 18:23:37 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PPC]  2.6.7-rc3 IBM405EP kernel won't build without PCI
Message-ID: <20040612012337.GA8154@gate.ebshome.net>
Mail-Followup-To: Aubin LaBrosse <arl8778@rit.edu>,
	Michael Clark <michael@metaparadigm.com>,
	linux-kernel@vger.kernel.org, benh@kernel.crashing.org
References: <1086930832.8686.50.camel@lhosts> <40C9CC65.5030209@metaparadigm.com> <1086997505.15798.8.camel@lhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086997505.15798.8.camel@lhosts>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 07:45:05PM -0400, Aubin LaBrosse wrote:
> Although I should still be able to build the kernel without pci support,
> shouldn't I?

Yes, correctly configured board port for 405EP can be build without PCI support.

> Where does the CONFIG_BIOS_FIXUP come from and is it necessary for a
> device like this is I guess what I'm asking -  the code compiled in by
> CONFIG_BIOS_FIXUP seems to depend on PCI being in but you can select it
> without selecting PCI -  that's the underlying issue here I think.  I
> assume I don't really need CONFIG_BIOS_FIXUP for this device (given the
> name of the option, I would hope that this thing doesn't have a bios
> that needs 'fixing
> up') but I'm not even sure how to turn it off... and of course I'm only
> guessing based on the error I got and the names of the things involved,
> i haven't rolled up my sleeves and got into it yet..

Did you make board port yourself? The reason I'm asking is none of Linux PPC 
trees has support for board you mentioned. So it's quite unlikely that Linux PPC 
kernel can be used on your hardware as is.

.config file doesn't look correct, it enables support for EP405 board (Embedded 
Plannet 405GP based board).

CONFIG_BIOS_FIXUP is set arch/ppc/platforms/4xx/Kcoonfig on per board basis.

Also, I'd recommend asking questions about 405EP on linuxppc-embedded list, not 
here. This will increase probability of you getting some help :).

Eugene
