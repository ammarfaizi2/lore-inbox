Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTFBMTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTFBMTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:19:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39949 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262252AbTFBMTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:19:37 -0400
Date: Mon, 2 Jun 2003 13:32:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Haverkamp <markh@osdl.org>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci bridge class code
Message-ID: <20030602133258.A776@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Haverkamp <markh@osdl.org>, Patrick Mochel <mochel@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net> <20030529214044.B30661@flint.arm.linux.org.uk> <1054287852.23562.2.camel@dhcp22.swansea.linux.org.uk> <1054554964.535.35.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1054554964.535.35.camel@gaston>; from benh@kernel.crashing.org on Mon, Jun 02, 2003 at 01:56:04PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 01:56:04PM +0200, Benjamin Herrenschmidt wrote:
> On Fri, 2003-05-30 at 11:44, Alan Cox wrote:
> 
> > The same is true of serveral hot docking bridges such as the one on the
> > IBM TP600 and also of other devices which happen to be both a PCI-PCI
> > bridge and have other magic stuck on them. 
> 
> Maybe we could find some way to prioritize matching ? It's a bit late now,
> but well... if the match functions returned an integer, 0 beeing lower match,
> we could have some kind of prioritization.
> 
> That way, a class match would have lower priority than a vendorID/deviceID
> match, etc...

That would not help the case when you have the "generic" bridge module
loaded and the specific bridge driver as a loadable module.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

