Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755948AbWKQV6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbWKQV6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755956AbWKQV6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:58:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:27817 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1755948AbWKQV6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:58:19 -0500
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <chrmhoffmann@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20061117143658.GB5158@shaftnet.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	 <200611151109.06956.rjw@sisk.pl>
	 <200611162317.30880.chrmhoffmann@gmail.com>
	 <200611162344.41622.rjw@sisk.pl> <20061117052755.GA23831@shaftnet.org>
	 <1163744220.5940.443.camel@localhost.localdomain>
	 <20061117143658.GB5158@shaftnet.org>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 08:57:55 +1100
Message-Id: <1163800675.5826.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I understand what you're saying correctly, if we re-write a valid set
> of pci registers, we'll trash the radeon state?   Why _wouldn't_ a D3 
> resume be trashed?

No, we determine in advance what we support. On resume, we don't want to
do a full reset of the chip if it was not powered down. (Among others,
this isn't tested and we might not be doing it properly from a non
poweron-reset state).

Ben.


