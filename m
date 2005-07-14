Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263086AbVGNTy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbVGNTy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVGNTys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:54:48 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11916 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263086AbVGNTyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:54:36 -0400
Subject: Re: [RFC][PATCH] add PCI bus registration support [2/9]
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050714193351.GB31595@kroah.com>
References: <1121331313.3398.90.camel@localhost.localdomain>
	 <20050714193351.GB31595@kroah.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 15:46:46 -0400
Message-Id: <1121370406.3398.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 12:33 -0700, Greg KH wrote:
> On Thu, Jul 14, 2005 at 04:55:12AM -0400, Adam Belay wrote:
> > +EXPORT_SYMBOL(pci_add_bus);
> 
> This doens't need to be exported, right?  No module uses it.  But if
> they do, I suggest EXPORT_SYMBOL_GPL() instead, is that ok?
> 
> thanks,
> 
> greg k-h

Yes, no module currently uses it, but now that "pci_driver" is
supported, any PCI bridge driver could potentially be made into a
module.  In theory, this could even include the PCI<->PCI bridge driver.
I also wanted to export this as a module so that it would be easier to
add new drivers for more unusual bridge hardware.  EXPORT_SYMBOL_GPL()
would be fine.

Thanks,
Adam


