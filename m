Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVBXAJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVBXAJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVBWX6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:58:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:11168 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261725AbVBWXrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:47:40 -0500
Date: Wed, 23 Feb 2005 15:47:21 -0800
From: Greg KH <greg@kroah.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
Message-ID: <20050223234720.GA7270@kroah.com>
References: <20050223014233.6710fd73.akpm@osdl.org> <421C7FC2.1090402@aitel.hist.no> <20050223121207.412c7eeb.akpm@osdl.org> <421D0582.9090100@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421D0582.9090100@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 11:36:50PM +0100, Laurent Riffard wrote:
> hey, what's this /dev/hds ? digging into /sys/block...
> 
> ~$ ls -l  /sys/block/hds/device
> lrwxrwxrwx  1 root root 0 f?v 23 22:45 /sys/block/hds/device ->
> ../../devices/pci0000:00/0000:00:04.1/ide1/1.1/
> 
> /dev/hdq should be /dev/hdd...
> 
> ~$ ls -l /proc/ide
> total 4
> -r--r--r--  1 root root 0 f?v 23 23:28 drivers
> lrwxrwxrwx  1 root root 8 f?v 23 23:28 hda -> ide0/hda/
> lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdb -> ide0/hdb/
> lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdc -> ide1/hdc/
> lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdd -> ide1/hdd/
> dr-xr-xr-x  4 root root 0 f?v 23 23:28 ide0/
> dr-xr-xr-x  4 root root 0 f?v 23 23:28 ide1/
> -r--r--r--  1 root root 0 f?v 23 23:28 via
> ~$ ls -d /sys/block/hd*
> /sys/block/hda/  /sys/block/hdc/  /sys/block/hdq/  /sys/block/hds/

What does /proc/devices show?

thanks,

greg k-h
