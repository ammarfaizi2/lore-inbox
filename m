Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVDBT1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVDBT1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDBT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:27:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:16775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbVDBT11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:27:27 -0500
Date: Sat, 2 Apr 2005 11:26:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI Hotplug: remove code duplication in
 drivers/pci/hotplug/ibmphp_pci.c
Message-Id: <20050402112654.3b12a3a5.akpm@osdl.org>
In-Reply-To: <200504021420.16772@bilbo.math.uni-mannheim.de>
References: <1112399271636@kroah.com>
	<200504021420.16772@bilbo.math.uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike-hotplug@sf-tec.de> wrote:
>
> Greg KH wrote:
> > ChangeSet 1.2181.16.9, 2005/03/17 13:54:33-08:00, eike-hotplug@sf-tec.de
> >
> > [PATCH] PCI Hotplug: remove code duplication in
> > drivers/pci/hotplug/ibmphp_pci.c
> >
> > This patch removes some code duplication where if and else have the
> > same code at the beginning and the end of the branch.
> 
> Greg, as you correctly pointed out this patch if broken. It could never reach 
> the if branch and always uses the else branch. Please drop this one and 
> review the patch I sent on March 21th to pcihp-discuss for inclusion. It 
> removes much more duplication and handles this case correctly. Sorry, it 
> looks like I forgot to CC you. I'll bounce this mail to you.
> 

It's merged now, so sending a new patch which fixes that file up might be
simpler and less error-prone.

Latest ibmphp_pci.c causes gcc-2.95.4 to go into an infinite loop,
consuming 750MB of memory, which is a bit irritating.

