Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVALNJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVALNJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVALNJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:09:11 -0500
Received: from coderock.org ([193.77.147.115]:9419 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261176AbVALNJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:09:07 -0500
Date: Wed, 12 Jan 2005 14:09:01 +0100
From: Domen Puncer <domen@coderock.org>
To: Greg KH <greg@kroah.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI patches for 2.6.10
Message-ID: <20050112130901.GJ4978@nd47.coderock.org>
References: <20050110171827.GA30296@kroah.com> <11053776551683@kroah.com> <20050111223902.GJ2995@waste.org> <20050111224447.GA19240@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111224447.GA19240@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/05 14:44 -0800, Greg KH wrote:
> On Tue, Jan 11, 2005 at 02:39:02PM -0800, Matt Mackall wrote:
> > On Mon, Jan 10, 2005 at 09:20:55AM -0800, Greg KH wrote:
> > > ChangeSet 1.1938.439.44, 2005/01/07 10:32:39-08:00, domen@coderock.org
> > > 
> > > [PATCH] hotplug/acpiphp_ibm: module_param fix
> > > 
> > > File permissins should be octal number.
> > 
> > > -module_param(debug, bool, 644);
> > > +module_param(debug, bool, 0644);
> > 
> > Perhaps the sysfs code could do:
> > 
> > 	/* did we forget to write in octal? */
> > 	BUG_ON(mode > 0666 || mode & 0111);

Some drivers assumed last parameter is default value, so this wouldn't
help in all cases :-)

> 
> I think the whole tree has now been audited.  Mistakes from now on are
> the developer who did the change's fault (like all other kernel bugs...)

I think I checked all of them.


	Domen
