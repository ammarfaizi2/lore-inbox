Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWBTUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWBTUjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWBTUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:39:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161166AbWBTUjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:39:24 -0500
Date: Mon, 20 Feb 2006 12:37:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] mm/mempolicy.c: fix 'if ();' typo
Message-Id: <20060220123743.00adf162.akpm@osdl.org>
In-Reply-To: <20060220145703.GA8200@mipter.zuzino.mipt.ru>
References: <20060220145703.GA8200@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  mm/mempolicy.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -587,7 +587,7 @@ redo:
>  		}
>  		list_add(&page->lru, &newlist);
>  		nr_pages++;
> -		if (nr_pages > MIGRATE_CHUNK_SIZE);
> +		if (nr_pages > MIGRATE_CHUNK_SIZE)
>  			break;
>  	}
>  	err = migrate_pages(pagelist, &newlist, &moved, &failed);

rofl.  That should speed things up a bit, thanks.
