Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFFJYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFFJYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFFJYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:24:34 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:57803 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261249AbVFFJYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:24:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l1LENDt+EGGW4uWwVKWTRLqN3D2fqyIZeZ+Cpzl0GJV/VAo3/RHkI9fQwkFoKAkCQM2rLUPHWARmifp6O5sbAvpPEHUQ/fB58vZeP3iRMtczk3Cz+ng+dwTS4kqiIxIIKsogWxf9d9f+8/3wIC4w2+GleIrJd57CkEh4ZksqXvc=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ericvh@gmail.com
Subject: Re: v9fs-vfs-file-dentry-and-directory-operations.patch added to -mm tree
Date: Mon, 6 Jun 2005 13:28:01 +0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200506060624.j566OQpF010552@shell0.pdx.osdl.net>
In-Reply-To: <200506060624.j566OQpF010552@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506061328.02594.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 10:24, akpm@osdl.org wrote:
>      v9fs: VFS file, dentry, and directory operations

> --- /dev/null
> +++ 25-akpm/fs/9p/vfs_file.c

> +static ssize_t
> +v9fs_file_read(struct file *filp, char __user * data, size_t count,
> +	       loff_t * offset)
> +{

> +	char *buffer = NULL;

Unneeded assignment.

> +	buffer = kmalloc(count, GFP_KERNEL);
> +	if (buffer < 0)
> +		return -ENOMEM;

buffer is a pointer.
