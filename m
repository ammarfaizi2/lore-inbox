Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752402AbWCPQtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbWCPQtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbWCPQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:49:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27562 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751241AbWCPQtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:49:36 -0500
Date: Thu, 16 Mar 2006 16:49:32 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316164932.GT27946@ftp.linux.org.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 02:01:28AM -0800, akpm@osdl.org wrote:
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> We have no less than 65 implementations of TRUE and FALSE in the tree, so the
> inevitable happened:
> 
> In file included from drivers/pci/hotplug/ibmphp_core.c:40:
> drivers/pci/hotplug/ibmphp.h:409:1: warning: "FALSE" redefined
> In file included from include/acpi/acpi.h:55,
>                  from drivers/pci/hotplug/pci_hotplug.h:187,
>                  from drivers/pci/hotplug/ibmphp.h:33,
>                  from drivers/pci/hotplug/ibmphp_core.c:40:
> include/acpi/actypes.h:336:1: warning: this is the location of the previous definition
> 
> The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
> the private versions.

NAK.  Simply remove those and be done with that.  It's bad style and we
certainly don't need to propagate that lossage.

..oO[and no, #define BEGIN { is also not kernel.h fodder]
