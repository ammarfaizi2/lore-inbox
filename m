Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUKIW4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUKIW4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUKIW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:56:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:60571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261756AbUKIW4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:56:41 -0500
Date: Tue, 9 Nov 2004 14:55:02 -0800
From: Greg KH <greg@kroah.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, tokunaga.keiich@jp.fujitsu.com,
       motoyuki@soft.fujitsu.com, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, rml@novell.com,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041109225502.GC7618@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de> <20041105180513.GA32007@kroah.com> <20041105201012.GA24063@vrfy.org> <20041105204209.GA1204@kroah.com> <20041105211848.A21098@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105211848.A21098@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 09:18:48PM -0800, Keshavamurthy Anil S wrote:
> Also, since you have brought this, I have one another question to you.
> Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> an "ADD" notification is sent. why is this? I would like to call
> kobject_hotplug(kobj, ADD) later.

This happens when kobject_add() is called.  You shouldn't ever need to
call kobject_hotplug() for an add event yourself.

thanks,

greg k-h
