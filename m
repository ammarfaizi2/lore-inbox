Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUHCMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUHCMvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHCMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:51:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23691 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266133AbUHCMvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:51:31 -0400
Date: Tue, 3 Aug 2004 13:47:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] Use sysfs_dirent tree for ->readdir etc.
Message-ID: <20040803124719.GT12308@parcelfarce.linux.theplanet.co.uk>
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729203919.GD4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:39:19PM -0500, Maneesh Soni wrote:
> 
> o This patch implements the sysfs_dir_operations file_operations strucutre for 
>   sysfs directories. It uses the sysfs_dirent based tree for ->readdir() and 
>   ->lseek() methods instead of simple_dir_operations which use dentry based 
>   tree.
> 
> o This also has the code for sysfs_get() and sysfs_put() which manipulates
>   the reference counting for for sysfs_dirents.

ACK, except that I'd move refcounting primitives to the chunk that actually
uses them.
