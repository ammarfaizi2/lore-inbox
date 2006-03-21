Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWCUHOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWCUHOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWCUHOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:14:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932284AbWCUHOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:14:37 -0500
Subject: Re: [PATCH 2.6.16-rc6-xen] export Xen Hypervisor attributes to
	sysfs
From: Arjan van de Ven <arjan@infradead.org>
To: ncmike@us.ibm.com
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>
References: <200603202335.k2KNZEjo005673@mdday.raleigh.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 08:14:29 +0100
Message-Id: <1142925269.3077.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 18:35 -0500, Mike D. Day wrote:
> Creates a module that exports Xen Hypervisor attributes to sysfs. The
> module has a tri-state configuration so it can be a loadable module.
> 
> Views the hypervisor as hardware device, uses sysfs as  a scripting
> interface for user space tools that need these attributes.
> 
> Some user space apps, particularly for systems management, need to
> know if their kernel is running in a virtual machine and if so in
> what type of virtual machine. This property is contained in the
> file /sys/hypervisor/type.
> 
> The file hypervisor_sysfs.c creates a generic  hypervisor subsystem
> that can be linked to by any hypervisor. The file xen_sysfs.c exports
> the xen-specific attributes.
> 
> signed-off-by: Mike D. Day <ncmike@us.ibm.com>
> 
> ---
> Initial directory = /sys/hypervisor
> +---compilation
> |   >---compile_date
> |   >---compiled_by
> |   >---compiler
> +---properties
> |   >---capabilities
> |   >---changeset

how is this a property and not part of version?

> |   >---virtual_start
> |   >---writable_pt
> >---type
> +---version
> |   >---extra
> |   >---major
> |   >---minor
> 


again what is the justification of putting this in the kernel? I though
everyone here was agreed that since the management tools that need this
talk to the hypervisor ANYWAY, they might as well just ask this
information as well....



