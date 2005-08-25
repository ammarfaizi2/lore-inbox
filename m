Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVHYQAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVHYQAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVHYQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:00:18 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:36711 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932212AbVHYQAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:00:17 -0400
Date: Thu, 25 Aug 2005 18:00:16 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050825160016.GC20557@harddisk-recovery.com>
References: <200508251538.j7PFcn1g000143@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508251538.j7PFcn1g000143@ms-smtp-01.rdc-nyc.rr.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 11:38:49AM -0400, robotti@godmail.com wrote:
> What if you have a root.cpio.gz that requires 200MB to hold, but you
> only have 300MB of memory?
> 
> 50% of total memory wouldn't hold it, but 90% etc. would (tmpfs_size=90%).

tmpfs will not help you here. Yes, it can be swapped, but just like
with ramfs you first need to *unpack* the cpio archive before you can
even start the "swapon /dev/hda2" command on it.

Same with initrd, btw. If the compressed initrd image, plus the
uncompressed image, plus the kernel size are larger than the memory
size, the system will not boot.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
