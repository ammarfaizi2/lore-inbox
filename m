Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTFTN5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTFTN5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:57:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61849 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262263AbTFTN5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:57:32 -0400
Date: Fri, 20 Jun 2003 15:11:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reimplement pci proc name
Message-ID: <20030620141132.GS24357@parcelfarce.linux.theplanet.co.uk>
References: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk> <20030620160228.654e181c.martin.zwickel@technotrend.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620160228.654e181c.martin.zwickel@technotrend.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 04:02:28PM +0200, Martin Zwickel wrote:
> Hi Matthew!
> 
> Just one question:
> If pci_name_bus copies the bus' hex to name and always returns 0,
> the "if (!pci_name_bus(name, bus)) return -EEXIST;" would always be true, right?
> 
> Or did I miss something?

That's currently correct.  My understanding is that some architectures
would like to decline to create overlapping bus numbers.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
