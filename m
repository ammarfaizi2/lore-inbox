Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVAKWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVAKWtP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVAKWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:45:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61857 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262920AbVAKWow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:44:52 -0500
Date: Tue, 11 Jan 2005 14:44:47 -0800
From: Greg KH <greg@kroah.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI patches for 2.6.10
Message-ID: <20050111224447.GA19240@kroah.com>
References: <20050110171827.GA30296@kroah.com> <11053776551683@kroah.com> <20050111223902.GJ2995@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111223902.GJ2995@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 02:39:02PM -0800, Matt Mackall wrote:
> On Mon, Jan 10, 2005 at 09:20:55AM -0800, Greg KH wrote:
> > ChangeSet 1.1938.439.44, 2005/01/07 10:32:39-08:00, domen@coderock.org
> > 
> > [PATCH] hotplug/acpiphp_ibm: module_param fix
> > 
> > File permissins should be octal number.
> 
> > -module_param(debug, bool, 644);
> > +module_param(debug, bool, 0644);
> 
> Perhaps the sysfs code could do:
> 
> 	/* did we forget to write in octal? */
> 	BUG_ON(mode > 0666 || mode & 0111);

I think the whole tree has now been audited.  Mistakes from now on are
the developer who did the change's fault (like all other kernel bugs...)

thanks,

greg k-h
