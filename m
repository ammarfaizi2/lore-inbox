Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVJZVV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVJZVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVJZVV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:21:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41932 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964937AbVJZVV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:21:27 -0400
Date: Wed, 26 Oct 2005 22:21:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roland Dreier <rolandd@cisco.com>
Cc: Laurent riffard <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 2/3] remove pci_driver.owner and .name fields
Message-ID: <20051026212127.GU7992@ftp.linux.org.uk>
References: <20051026204802.123045000@antares.localdomain> <20051026204909.576265000@antares.localdomain> <52vezkyoor.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52vezkyoor.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 02:05:08PM -0700, Roland Dreier wrote:
>         > -	.name		= "DAC960",
>         > +	.driver = {
>         > +		.name	= "DAC960",
>         > +	},
> 
> This change looks like a (rather ugly) step backwards.  Maybe it would
> be better to add the name as a parameter to pci_register_driver?

It looks stupid in the first place - what's wrong with
		.driver.name = "DAC960",
instead of that mess?
