Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUHFAl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUHFAl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHFAl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:41:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:16820 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268028AbUHFAlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:41:24 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091745102.2530.24.camel@laptop.cunninghams>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
	 <1091592870.5226.80.camel@gaston>
	 <1091593555.3191.48.camel@laptop.cunninghams>
	 <1091595125.5227.96.camel@gaston>
	 <1091595258.3303.74.camel@laptop.cunninghams>
	 <1091595811.5226.105.camel@gaston>
	 <1091745102.2530.24.camel@laptop.cunninghams>
Content-Type: text/plain
Message-Id: <1091752742.1899.213.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 06 Aug 2004 10:39:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 08:31, Nigel Cunningham wrote:
> Hi again.
> 
> On Wed, 2004-08-04 at 15:03, Benjamin Herrenschmidt wrote:
> > That's where the whole confusion is indeed... and why we need to make
> > that clear. The IDE driver will sleep the disk for 3 and keep it spinning
> > for 4
> 
> Okay. So that leaves me calling device_suspend(4) when I want to quiesce
> the driver but not spin down and device_suspend(3) when I want to power
> down. Does that sound right? It sounds hairy to me. (Do other drivers
> treat 3 and 4 in the same way?)

Well, or just continue using the PM_ constants and change them to 1,3,4
like I did. It's the simplest way at this point imho.

Ben.


