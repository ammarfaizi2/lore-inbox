Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWEDTm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWEDTm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWEDTm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:42:29 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:62359 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750732AbWEDTm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:42:28 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, pjones@redhat.com,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
In-Reply-To: <200605041326.36518.bjorn.helgaas@hp.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <200605041309.53910.bjorn.helgaas@hp.com> <445A51F1.9040500@linux.intel.com> <445A51F1.9040500@linux.intel.com> <200605041326.36518.bjorn.helgaas@hp.com>
Date: Thu, 4 May 2006 20:42:17 +0100
Message-Id: <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> There's already a "rom" file in sysfs.  Could vbetool and friends
> use that?

Not if you have multiple graphics cards.

> How do vbetool and X coordinate their usage of "enable"?

vbetool won't run at anything other than a text console, and X won't 
mess with the graphics card if it's not on the current VT. You can mess 
this up if you try hard enough (multihead, for instance) but by and 
large it's a situation that you can avoid.

> What if we throw an in-kernel VGA driver into the mix?  But I guess
> Jon has asked all these questions before; I just didn't get warm
> fuzzies that there were safe, maintainable answers.

This probably isn't the right long-term answer, but the right long-term 
answer is going to be a very long time away. It's an improvement over 
what we have now. I certainly don't intend to leave vbetool relying on 
it - of course, the "right" answer is for graphics drivers to know how 
to program cards from scratch so we can get rid of vbetool altogether, 
but I'll probably be more concerned about getting my flying car to meet 
new emission standards than I will be by graphics cards at that stage.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
