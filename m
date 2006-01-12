Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWALTbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWALTbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWALTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:31:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:64946 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161208AbWALTbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:31:41 -0500
Date: Thu, 12 Jan 2006 11:30:57 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Gerd Hoffmann <kraxel@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112193057.GA13539@kroah.com>
References: <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de> <20060112173926.GD10513@kroah.com> <43C6A5B4.80801@us.ibm.com> <20060112190845.GA13073@kroah.com> <43C6AB78.1040301@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C6AB78.1040301@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:18:16PM -0500, Mike D. Day wrote:
> Greg KH wrote:
> 
> >
> >Why not do the same thing that the Cell developers did for their
> >"special syscalls"?  Or at the least, make it a "real" syscall like the
> >ppc64 developers did.  It's not like there isn't a whole bunch of "prior
> >art" in the kernel today that you should be ignoring.
> 
> A hypercall syscall would be good in a lot of ways. For x86/x86_64 there 
> are multiple hypervisors so we would need to make the syscall general 
> enough to support more than one hypervisor.

Why?  What's wrong with one syscall per hypervisor?  It's not like we
have a problem with adding 3 syscalls vs. 1.  Let the other hypervisors
also ask for a new syscall when they get added to the kernel tree.

And this also will let the kernel community monitor what you do with
that syscall more carefully (i.e. you only better use it for
pass-through hypervisor stuff, and not as a general multiplexor for
other things...)

thanks,

greg k-h
