Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269045AbUIQXqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269045AbUIQXqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 19:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269046AbUIQXqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 19:46:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:52384 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269045AbUIQXpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 19:45:52 -0400
Date: Fri, 17 Sep 2004 14:49:43 -0700
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-ID: <20040917214943.GE14340@kroah.com>
References: <41498CF6.9000808@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41498CF6.9000808@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:54:14PM +0900, Kenji Kaneshige wrote:
> Hi,
> 
> This patch adds a hook 'pcibios_disable_device()' into
> pci_disable_device() to call architecture specific PCI resource
> deallocation code. It's a opposite part of pcibios_enable_device().
> We need this hook to deallocate architecture specific PCI resource
> such as IRQ resource, etc.. This patch is just for adding the hook,
> so pcibios_disable_device() is defined as a null function on all
> architecture so far.

I'd prefer to wait until there was an actual user of this hook before
adding it to the kernel.  Otherwise someone (likely me) will notice this
hook in a few days and go, "hey, no one is using this, let's clean it
up" :)

So, how about we wait until you have a patch that needs this before I
apply it?

thanks,

greg k-h
