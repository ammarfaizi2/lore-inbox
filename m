Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVJZVfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVJZVfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVJZVfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:35:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964937AbVJZVfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:35:15 -0400
Date: Wed, 26 Oct 2005 14:35:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: rolandd@cisco.com, laurent.riffard@free.fr, linux-kernel@vger.kernel.org,
       greg@kroah.com, rmk+lkml@arm.linux.org.uk
Subject: Re: [RFC patch 2/3] remove pci_driver.owner and .name fields
Message-Id: <20051026143504.15064020.akpm@osdl.org>
In-Reply-To: <20051026212127.GU7992@ftp.linux.org.uk>
References: <20051026204802.123045000@antares.localdomain>
	<20051026204909.576265000@antares.localdomain>
	<52vezkyoor.fsf@cisco.com>
	<20051026212127.GU7992@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Wed, Oct 26, 2005 at 02:05:08PM -0700, Roland Dreier wrote:
> >         > -	.name		= "DAC960",
> >         > +	.driver = {
> >         > +		.name	= "DAC960",
> >         > +	},
> > 
> > This change looks like a (rather ugly) step backwards.  Maybe it would
> > be better to add the name as a parameter to pci_register_driver?
> 
> It looks stupid in the first place - what's wrong with
> 		.driver.name = "DAC960",
> instead of that mess?

gcc-2.95.x doesn't support that.
