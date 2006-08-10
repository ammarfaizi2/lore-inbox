Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWHJWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWHJWVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWHJWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:21:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751218AbWHJWVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:21:11 -0400
Date: Thu, 10 Aug 2006 15:18:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-fsdevel@vger.kernel.org,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/5] Forking ext4 filesystem from ext3
 filesystem
Message-Id: <20060810151813.ae352cd8.akpm@osdl.org>
In-Reply-To: <m3irl0l2is.fsf@bzzz.home.net>
References: <1155172622.3161.73.camel@localhost.localdomain>
	<20060809233914.35ab8792.akpm@osdl.org>
	<44DB8036.5020706@us.ibm.com>
	<44DB936D.2080909@garzik.org>
	<20060810132720.4d9fced4.akpm@osdl.org>
	<44DB9E6C.9070808@garzik.org>
	<m3irl0l2is.fsf@bzzz.home.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 01:11:23 +0400
Alex Tomas <alex@clusterfs.com> wrote:

>  >> A buffer_head is the kernel's sole abstraction of a disk block. 
>  >> Filesystems use disk blocks a lot, and they need such an abstraction.
> 
>  JG> IMO Al Viro work has shown that you can do pagecache I/O without needing 
>  JG> such a heavyweight system.
> 
> in delayed allocation patch for ext3 (ontop of extents) we do use
> bio's for data.

As does ext3 with `-o writeback,nobh'.
