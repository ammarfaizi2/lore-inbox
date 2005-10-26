Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVJZVFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVJZVFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVJZVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:05:19 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:57607 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964905AbVJZVFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:05:18 -0400
To: Laurent riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 2/3] remove pci_driver.owner and .name fields
X-Message-Flag: Warning: May contain useful information
References: <20051026204802.123045000@antares.localdomain>
	<20051026204909.576265000@antares.localdomain>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 26 Oct 2005 14:05:08 -0700
In-Reply-To: <20051026204909.576265000@antares.localdomain> (Laurent
 riffard's message of "Wed, 26 Oct 2005 22:48:04 +0200")
Message-ID: <52vezkyoor.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 26 Oct 2005 21:05:10.0284 (UTC) FILETIME=[F34A1CC0:01C5DA70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        > -	.name		= "DAC960",
        > +	.driver = {
        > +		.name	= "DAC960",
        > +	},

This change looks like a (rather ugly) step backwards.  Maybe it would
be better to add the name as a parameter to pci_register_driver?

 - R.
