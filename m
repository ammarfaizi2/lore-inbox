Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVAXXXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVAXXXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVAXXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:23:19 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:42293 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261722AbVAXXLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:11:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QdIcXPhjFNmEddi62pVmGeR8lu2JYd3eCZfKUDRfwZPmUYuwC1FNi3LYsaMAnJn1QnIY1GN4SvwP6qmNkSmqkk6tw4ohNg6m8RhCuVcDNoakMRHOBMWfqT6PvP4H2mo0VvROveGNDXAra9E7xcmeMdFTb1R8M+/DrSN5pKOehjw=
Message-ID: <9e4733910501241511d0d91b4@mail.gmail.com>
Date: Mon, 24 Jan 2005 18:11:37 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
In-Reply-To: <20050124195523.B5541@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <41ED3BD2.1090105@pobox.com>
	 <9e473391050122083822a7f81c@mail.gmail.com>
	 <200501240847.51208.jbarnes@sgi.com>
	 <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk>
	 <9e473391050124111767a9c6b7@mail.gmail.com>
	 <41F54FC1.6080207@pobox.com>
	 <20050124195523.B5541@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 19:55:23 +0000, Russell King
<rmk+lkml@arm.linux.org.uk> wrote:
> There's a very good reason not to have a bridge driver at the moment -
> some PCI to PCI bridges need special drivers.  Currently, as the device
> model stands today, we can only have ONE PCI to PCI bridge driver for
> all P2P bridges, which is bad news if you need a specific driver for,
> eg, a mobility docking station P2P bridge.

There is no requirement that the bridge driver be generic code. I
agree that it is simpler but there is nothing stopping a "generic"
driver from just having PCI IDs for all of the existing bridges built
into it and then load it like a normal driver. Loading all of the
bridge PCI IDs into the "generic" driver gets rid of the need for
driver priorities.

-- 
Jon Smirl
jonsmirl@gmail.com
