Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUD1VsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUD1VsC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUD1Tnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:43:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:39625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264961AbUD1QwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:52:25 -0400
Date: Wed, 28 Apr 2004 09:51:48 -0700
From: Greg KH <greg@kroah.com>
To: Michael Brown <Michael_E_Brown@Dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, matt_domsch@Dell.com
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
Message-ID: <20040428165148.GB32040@kroah.com>
References: <1083119269.1203.2821.camel@debian> <20040428033020.GA14078@kroah.com> <1083124552.1198.2835.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083124552.1198.2835.camel@debian>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 10:55:52PM -0500, Michael Brown wrote:
> On Tue, 2004-04-27 at 22:30, Greg KH wrote:
> > > +	snprintf(sdev->kobj.name, 7, "smbios" );
> > 
> > Try using kobject_set_name() instead, it will do the proper thing if the
> > string is bigger than the base kobj.name field.
> 
> Looks like this API was added in Aug03. A quick grep through the tree
> shows only <10 users. Are there patches pending to convert others, or
> are you just having new stuff do this?

New stuff should use it, and if you want to convert any current code to
also use it, please feel free to, I'll gladly take those patches.

thanks,

greg k-h
