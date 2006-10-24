Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWJXHk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWJXHk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWJXHk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:40:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:29410 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752105AbWJXHkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:40:24 -0400
Subject: Re: pci_set_power_state() failure and breaking suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux1394-devel@lists.sourceforge.net
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <1161672898.10524.596.camel@localhost.localdomain>
References: <1161672898.10524.596.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 17:40:11 +1000
Message-Id: <1161675611.10524.598.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 16:54 +1000, Benjamin Herrenschmidt wrote:
> So I noticed a small regression that I think might uncover a deeper
> issue...
> 
> Recently, ohci1394 grew some "proper" error handling in its suspend
> function, something that looks like:
> 
>         err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
>         if (err)
>                 goto out;
> 
> First, it breaks some old PowerBooks where the internal OHCI had PM
> feature exposed on PCI (the pmac specific code that follows those lines
> is enough on those machines).

If I could type, the above would have read...

First, it breaks some old PowerBooks where the internal OHCI has no PM
feature exposed on PCI....

Ben.


