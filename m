Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVBRTDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVBRTDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVBRTDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:03:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:14987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261448AbVBRTCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:02:45 -0500
Date: Fri, 18 Feb 2005 11:02:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, david@fubar.dk
Subject: Re: [PATCH] add I/O error uevent for block devices
Message-Id: <20050218110232.6512f0fb.akpm@osdl.org>
In-Reply-To: <20050218124503.GA7705@vrfy.org>
References: <20050218083316.GA6619@vrfy.org>
	<20050218014621.0b453232.akpm@osdl.org>
	<20050218124503.GA7705@vrfy.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> wrote:
>
>  > - there are numerous other places where an I/O error can be detected:
>  >   grep the tree for b_end_io and bio_end_io.
> 
>  You mean the mmap and direct-io stuff?

direct-io, certainly.  Also reiserfs, xfs, ntfs, ext3, jfs and possibly md
have their own I/O completion handlers.
