Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUEZJyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUEZJyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUEZJyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:54:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:23260 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265395AbUEZJxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:53:55 -0400
Date: Wed, 26 May 2004 11:53:51 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-ID: <20040526095351.GC28430@suse.de>
References: <20040525184732.GB26661@suse.de> <20040525144836.1af59a96.akpm@osdl.org> <20040525145923.68af0ad8.akpm@osdl.org> <20040525154107.053b9ef6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040525154107.053b9ef6.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, May 25, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Everything there is consistent with "not doing readahead".
> >
> 
> 
> 
> We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
> points at the right thing.  And we need to get it from
> inode->i_mapping->host->i_mapping too, which represents the underlying device.

That fixed it, thanks for the patch and the award!
I will take the patch and pass the award to the guy who found the bug.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
