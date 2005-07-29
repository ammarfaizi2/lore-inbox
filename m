Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVG2WYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVG2WYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVG2WVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:21:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58578 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262904AbVG2WVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:21:19 -0400
Message-ID: <42EAABD1.8050903@pobox.com>
Date: Fri, 29 Jul 2005 18:21:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
CC: mj@ucw.cz, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410>
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaston, Jason D wrote:
> This define is not actually used anywhere that I know of.  I just wanted
> to be consistent and correct, following what was previously done.  I
> have been wondering if I should be adding devices to the pci_ids.h file
> that are not being currently used.  It seems like most drivers are not
> using these defines and are just using the DID's directly.  In the
> future, should I only be add devices that are actually using the defines
> somewhere?

There's no clear policy, but that is my general recommendation:  Just 
add IDs to pci.ids at sourceforge.net as soon as their public, and then, 
add constants to include/linux/pci_ids.h as they are required in the code.

I would -prefer- that this be kernel policy, but I can only speak for 
IDs used [or not] in my drivers.  It just seems silly to add constants 
that are never used, though.

[speaking to the audience]  I wouldn't mind if someone did a pass 
through pci_ids.h and removed all the constants that are not being used. 
  If constants are not being used, it's IMHO more appropriate to store 
that info in pci.ids.

	Jeff



