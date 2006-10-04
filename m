Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWJDM0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWJDM0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbWJDM0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:26:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56980 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030201AbWJDM0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:26:44 -0400
Date: Wed, 4 Oct 2006 13:26:31 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/partitions/check: add sysfs error handling
Message-ID: <20061004122631.GJ29920@ftp.linux.org.uk>
References: <20061004121900.GA23988@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004121900.GA23988@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 08:19:00AM -0400, Jeff Garzik wrote:
> 
> Handle errors thrown in disk_sysfs_symlinks(), and propagate back
> to caller.
> 
> The callers and associated functions don't do a real good job
> of handling kobject errors anyway (add_partition, register_disk,
> rescan_partitions), so this should do until something better comes
> along.

I'm not sure that failure to create these symlinks should be fatal,
to be honest...
