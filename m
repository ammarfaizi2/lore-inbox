Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUBIRsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUBIRsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:48:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:36765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265280AbUBIRsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:48:50 -0500
Date: Mon, 9 Feb 2004 09:48:33 -0800
From: Greg KH <greg@kroah.com>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1-mm1 - Badness in kobject_get
Message-ID: <20040209174833.GA9639@kroah.com>
References: <1ngdf-3Qx-1@gated-at.bofh.it> <m3ptcotskr.fsf@terminal124.gozu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ptcotskr.fsf@terminal124.gozu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 12:12:20PM +0100, Ronny V. Vindenes wrote:
> During boot I get:
> 
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 152k freed
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c6405]
> Badness in kobject_get at lib/kobject.c:431
> Call Trace:
>  [<c020d15c>] kobject_get+0x4c/0x50
>  [<c025ca28>] get_device+0x18/0x30
>  [<c025d6a3>] bus_for_each_dev+0x63/0xc0
>  [<c02a9fdd>] nodemgr_node_probe+0x4d/0x130
>  [<c02a9ea0>] nodemgr_probe_ne_cb+0x0/0x90
>  [<c02aa439>] nodemgr_host_thread+0x179/0x1a0
>  [<c02aa2c0>] nodemgr_host_thread+0x0/0x1a0
>  [<c0109289>] kernel_thread_helper+0x5/0xc

Known issue, please read the archives.

Also, no one seems to know what the problem is :(

thanks,

greg k-h
