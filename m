Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755956AbWKQV7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956AbWKQV7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755960AbWKQV7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:59:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:38878 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1755956AbWKQV7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:59:53 -0500
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: Stuffed Crust <pizza@shaftnet.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200611172133.50049.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	 <20061117060758.GB25413@shaftnet.org> <20061117154119.GC5158@shaftnet.org>
	 <200611172133.50049.chrmhoffmann@gmail.com>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 08:59:28 +1100
Message-Id: <1163800768.5826.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I comment out the rinfo->asleep = 0; line, the machine comes back. So it 
> seems that rinfo struct is still corrupted somehow.

No, I don't think the rinfo is corrupted, I think the chip is in a state
the driver can't cope with. Possibly related to some PCI-Express
specific bits or to the memory map.

At this point, we'll need to do register dumps.

Ben.


