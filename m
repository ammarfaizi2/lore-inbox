Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTIQIIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 04:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTIQIIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 04:08:35 -0400
Received: from lidskialf.net ([62.3.233.115]:10646 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262705AbTIQIIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 04:08:34 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 Don't change BIOS allocated IRQs
Date: Wed, 17 Sep 2003 09:08:33 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com, Chris Wright <chrisw@osdl.org>
References: <200309170011.03630.adq_dvb@lidskialf.net> <20030917010254.GA1640@kroah.com>
In-Reply-To: <20030917010254.GA1640@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309170908.33295.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 September 2003 02:02, Greg KH wrote:
> On Wed, Sep 17, 2003 at 12:11:03AM +0100, Andrew de Quincey wrote:
> > With the help of Chris Wright testing several failed patches, I've
> > tracked down another ACPI IRQ problem. On many systems, the BIOS
> > pre-allocates IRQs for certain PCI devices, providing a list of alternate
> > possibilities as well.
> >
> > On some systems, changing the IRQ to one of those alternate possibilities
> > works fine. On others however, it really isn't a good idea. As theres no
> > way to tell which systems are good and bad in advance, this patch simply
> > ensures that ACPI does not change an IRQ if the BIOS has pre-allocated
> > it.
>
> Nice, the patch below, which Chris told me is from you, fixed my
> problems too.  It is against 2.6.0-test5-bk3 and fixes bug number 1186
> in the bugzilla.kernel.org database.
>
> Many thanks for this work, I really appreciate it.

Great! thanks for letting me know.

