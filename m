Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264738AbTFLNW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264752AbTFLNW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:22:26 -0400
Received: from AMarseille-201-1-3-129.w193-253.abo.wanadoo.fr ([193.253.250.129]:10535
	"EHLO gaston") by vger.kernel.org with ESMTP id S264738AbTFLNWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:22:25 -0400
Subject: Re: Looks like your PCI patch broke the PPC build (and others)?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, Miles Lane <miles.lane@attbi.com>,
       willy@debian.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <16104.10078.284006.569894@cargo.ozlabs.ibm.com>
References: <3EE77FD6.9020502@attbi.com> <20030611202811.GA26387@kroah.com>
	 <16104.10078.284006.569894@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055424925.604.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 15:35:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 09:10, Paul Mackerras wrote:
> Greg KH writes:
> 
> > Not my patch, Matthew's :)
> > 
> > I think the PPC developers have a fix for this.
> 
> Just #include <asm/pci-bridge.h> at the top of include/asm-ppc/pci.h.
> I'll push that change to Linus.

Well... asm/pci-bridge.h includes linux/pci.h which includes asm/pci.h,
so we have a circular include here...

What I did in my tree is to move the definition of pci_controller
from asm/pci-bridge.h to asm/pci.h. I'm now considering removing
asm/pci-bridge.h, what do you think ?

Ben.

