Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTEFACz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTEFACz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:02:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6276 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262069AbTEFACx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:02:53 -0400
Date: Mon, 5 May 2003 17:17:09 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt_Domsch@Dell.com, alan@redhat.com, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030506001709.GB3945@kroah.com>
References: <1051749599.20870.234.camel@iguana.localdomain> <20030502231558.GA16209@kroah.com> <3EB5F8B0.20501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB5F8B0.20501@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 01:37:52AM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >
> >But by adding the device ids, they will be persistant, for that driver,
> >right?  Then when the device is plugged in, the core will iterate over
> >the static and dynamic ids, right?  If so, I don't see how a "probe_it"
> >file is needed.
> 
> Consider the case:
> Device already exists, and is plugged in.  Like a standard PCI card.
> Driver doesn't support PCI id, and the sysadmin uses /bin/echo to add one.

Great, probe gets run right then, and that's what we want, right?

> For unplugged case, you know you don't need to re-run the probe.

But a probe scan across all devices doesn't really take much time,
right?  And yes this would be "redundant" but it's a whole lot tougher
to figure out that we don't need to re-run a probe, than to just always
do it :)

thanks,

greg k-h
