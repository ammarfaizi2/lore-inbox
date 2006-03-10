Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWCJRqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCJRqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWCJRqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:46:55 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:39323 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1751095AbWCJRqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:46:54 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Fri, 10 Mar 2006 09:46:12 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603091746.51686.dsp@llnl.gov> <1141976218.2876.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1141976218.2876.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603100946.12448.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 23:36, Arjan van de Ven wrote:
> ok so this is actually a per pci device property!
> I would suggest moving this property to the pci device itself, not doing
> it inside an edac directory.
>
> by doing that you get the advantage that 1) it's a more logical place,
> and 2) users can do it even for 1 of 2 cards, if they have 2 cards of
> the same make and 3) you can use the generic kernel quirk interface for
> this and 4) drivers can in principle control this for their hardware in
> complex cases
>
> I understand that on a PC, EDAC is the only user. but ppc has a similar
> mechanism I suspect, and they more than likely would be able to share
> this property....

I'd be curious to hear people's opinions on the following idea:
move the PCI bus parity error checking functionality from EDAC
to the PCI subsystem.
