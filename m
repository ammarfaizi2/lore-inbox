Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUHWNoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUHWNoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHWNoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:44:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39101 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264298AbUHWNoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:44:10 -0400
Date: Mon, 23 Aug 2004 09:25:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10]
Message-ID: <20040823122516.GC4569@logos.cnet>
References: <41222195.3020108@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41222195.3020108@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 06:17:41PM +0300, O.Sezer wrote:

> --- 28p1/include/linux/fs.h~	2004-08-16 20:23:00.000000000 +0300
> +++ 28p1/include/linux/fs.h	2004-08-17 13:02:49.000000000 +0300
> @@ -1528,7 +1528,7 @@
>  extern int generic_file_mmap(struct file *, struct vm_area_struct *);
>  extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
>  extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
> -extern inline ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
> +extern ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
>  extern int precheck_file_write(struct file *, struct inode *, size_t *, loff_t *);
>  extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
>  extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);

And what about the actual function declaration in mm/ ?

