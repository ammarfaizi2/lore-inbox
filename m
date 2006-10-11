Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWJKSYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWJKSYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWJKSYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:24:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:26980 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161178AbWJKSYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:24:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W+0cO/YftDnW1sdgjLF4cEf4TcVkXV8Atefn4QKnsae7/kYvaHQkIvyEkZgZKMHZsy0D8B5x9DMv4ChPiNvkWzZD00vZuXalypbJOJkNN0YDvN9F8VIXzsbNNmnBx7DTMQaIcUk5htpCm5szS1VbR4M5+Wfix2gHJYBkZYDNRhY=
Message-ID: <b6fcc0a0610111124j3a7d8575mefd218e23272ba0e@mail.gmail.com>
Date: Wed, 11 Oct 2006 22:24:41 +0400
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] misuse of strstr
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061011162545.GC29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061011162545.GC29920@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/fs/gfs2/locking/dlm/mount.c
> +++ b/fs/gfs2/locking/dlm/mount.c
> @@ -45,7 +45,7 @@ static struct gdlm_ls *init_gdlm(lm_call
>  	strncpy(buf, table_name, 256);
>  	buf[255] = '\0';
>
> -	p = strstr(buf, ":");
> +	p = strchr(buf, ':');

arch/mips/arc/cmdline.c:55: s = strstr(prom_argv(actr), "=");

sorry for absence of patch, I'm on wonders of BY dial-up _and_ Gmail
web interface right now.
