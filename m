Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWALRoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWALRoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWALRoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:44:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:54920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932445AbWALRoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:44:14 -0500
Date: Thu, 12 Jan 2006 09:43:13 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112174313.GE10513@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <20060112071000.GA32418@kroah.com> <43C66B56.8030801@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C66B56.8030801@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 09:44:38AM -0500, Mike D. Day wrote:
> Greg KH wrote:
> >What other, specific sysfs files are you going to want to create?
> >What is the hierarchy going to look like?
> >What is the contents of the file going to look like?
> 
> You make a very good point. We have not agreed on the heirarchy and file 
> contents, and  we need to do so before continuing.
> Some _very rough_ ideas include
> 
> /sys/xen/version/{major minor extra version build}
> /sys/xen/domain/{dom0 dom1 ... domn} (each domain could be a dir. with 
> attributes)
> /sys/xen/hypervisor/{scheduler cpu memory}
> /sys/xen/migrate/{hosts_to, hosts_from}
> 
> These will be text files with simple attrributes. Most will be 
> read-only. It is kind of fun to think about creating a domain by doing 
> something like
> 
> cat $domain_config > /sys/xen/domain/new
> 
> but there are some ugly aspects of doing so. Likewise it would be good 
> to add a potential migration host by writing an ip address to
> /sys/xen/migrate/hosts_to
> 
> Again, we need to get this solidified before going further.

Ok, feel free to come back when you get this information sorted out.

thanks,

greg k-h
