Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVAMT6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVAMT6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVAMT4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:56:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7653 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261485AbVAMTv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:51:27 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113180347.GB17600@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105641991.4664.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 18:46:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 18:03, Andi Kleen wrote:
> You are saying that X during its own private broken PCI scan
> stops scanning when it sees an errno? 
> 
> That sounds incredibly broken if true. I'm not sure how much
> effort the kernel should really take to work around such
> user breakage. I suppose an ffffffff return would work. 

X needs to be able to find the device layout in order to build its PCI
mappings. Cached data is probably quite sufficient for this.

> > Then you need to switch to wait_event_timeout(). Its not terribly hard
> > 8)
> 
> Just complicating something that should be very simple.

You are breaking an established user space API. Its not suprising this
will break applications is it. 

