Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFFKak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFFKak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 06:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFFKak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 06:30:40 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:65504 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261275AbVFFKae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 06:30:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IGNAfjDqulS6c7N1oohVzD16fGQMMWOtq9buzeOqKkw7R4CdfHpUR7VWmlIWFcXQnldw+MuF1xQDfhwaCTNVwYP8X/5SqDsxuHY4IZH2NVnpLMSx9uqQl3HPH1cNMPAeQrsZjKtOrscuAW1QSxNOP6UwrNAEmUM71xqP+8vENwU=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ericvh@gmail.com
Subject: Re: v9fs-vfs-superblock-operations-and-glue.patch added to -mm tree
Date: Mon, 6 Jun 2005 14:35:31 +0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200506060624.j566OUwN010567@shell0.pdx.osdl.net>
In-Reply-To: <200506060624.j566OUwN010567@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506061435.32476.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 10:24, akpm@osdl.org wrote:
>      v9fs: VFS superblock operations and glue

> --- /dev/null
> +++ 25-akpm/fs/9p/v9fs.c

> +int
> +v9fs_session_init(struct v9fs_session_info *v9ses,
> +		  const char *dev_name, char *data)
> +{

> +	v9ses->transport = kmalloc(sizeof(struct v9fs_transport), GFP_KERNEL);
> +	if (!v9ses->transport) {
> +		eprintk(KERN_WARNING,
> +			"Couldn't allocate string for transport struct\n");
> +		retval = -ENOMEM;
> +		goto SessCleanUp;
> +	}
> +
> +	v9ses->transport = trans_proto;

kmalloc and forget.
