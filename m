Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424094AbWKIQEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424094AbWKIQEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424096AbWKIQEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:04:07 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:9174 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1424094AbWKIQEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:04:04 -0500
Date: Thu, 9 Nov 2006 17:04:35 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/2] Add dev_sysdata and use it for ACPI
Message-ID: <20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1163033121.28571.792.camel@localhost.localdomain>
References: <1163033121.28571.792.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2006 11:45:21 +1100,
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

>  - Add a dev_sysdata structure to struct device whose content is arch
> specific. It will allow architectures like powerpc, arm, i386, ... who
> need different types of DMA ops for busses and other kind of auxilliary
> data for devices in general (numa node id, firmware data, etc...) to put
> them in there, without bloating all architectures. The patch adds an
> empty definition for the structure to all architectures.

I like this. If we could move the dma stuff in there, we could get rid
of it on s390 where it is just bloat we drag around...

(Maybe dev_archdata would be a better name, since the definition is
architecture specific?)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
