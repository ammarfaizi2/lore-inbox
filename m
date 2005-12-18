Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVLRNZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVLRNZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 08:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVLRNZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 08:25:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17594 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750829AbVLRNZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 08:25:30 -0500
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Robert Walsh <rjwalsh@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <p73k6e3dr05.fsf@verdi.suse.de>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	 <200512161548.lRw6KI369ooIXS9o@cisco.com>
	 <20051217123833.1aa430ab.akpm@osdl.org>
	 <1134859243.20575.84.camel@phosphene.durables.org>
	 <p73k6e3dr05.fsf@verdi.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Dec 2005 13:25:48 +0000
Message-Id: <1134912348.26141.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-12-18 at 04:27 +0100, Andi Kleen wrote:
> Robert Walsh <rjwalsh@pathscale.com> writes:
> > 
> > Any chance we could get these moved into the x86_64 arch directory,
> > then?  We have to do double-word copies, or our chip gets unhappy.
> 
> Standard memcpy will do double word copies if everything is suitably
> aligned. Just use that.

Sorry I have to disagree with that. The standard memcpy may change in
future to have different properties. If you really need specific unusual
properties then you want to be sure that it is obvious they are there.

I'd also like to see Dave's generic C implementation as I don't believe
you can create one the compiler isn't allowed at least technically to do
differently.

