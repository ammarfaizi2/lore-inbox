Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVAFVDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVAFVDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVAFU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:59:47 -0500
Received: from imap.gmx.net ([213.165.64.20]:60118 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262969AbVAFU6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:58:13 -0500
X-Authenticated: #1725425
Date: Thu, 6 Jan 2005 22:06:04 +0100
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Mike Werner <werner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opps 2.6.10-mm2
Message-Id: <20050106220604.27449c9a.Ballarin.Marc@gmx.de>
In-Reply-To: <41DD89EA.9F79D76C@sgi.com>
References: <41DD89EA.9F79D76C@sgi.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2005 10:56:42 -0800
Mike Werner <werner@sgi.com> wrote:

> Can you apply this and see if it helps you.
> 
> diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> --- a/drivers/char/agp/generic.c        2005-01-06 09:26:31 -08:00
> +++ b/drivers/char/agp/generic.c        2005-01-06 09:26:31 -08:00
> @@ -211,6 +211,7 @@
>                 new->memory[i] = virt_to_phys(addr);
>                 new->page_count++;
>         }
> +       new->bridge = bridge;
>  
>         flush_agp_mappings();

Works fine on nvidia-agp / radeon.

Regards
