Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUDROcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUDROcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 10:32:04 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:38328 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261162AbUDROcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 10:32:02 -0400
Date: Sun, 18 Apr 2004 16:37:34 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] Oprofilefs cant handle > 99 cpus
Message-ID: <20040418163734.GA384@zaniah>
References: <20040418110658.GC26086@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418110658.GC26086@krispykreme>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2004 at 21:06 +0000, Anton Blanchard wrote:

> 
> Hi,
> 
> Oprofilefs cant handle > 99 cpus. This should fix it.

right.
 
> ===== oprofile_stats.c 1.6 vs edited =====
> --- 1.6/drivers/oprofile/oprofile_stats.c	Mon Jan 19 17:33:51 2004
> +++ edited/oprofile_stats.c	Sun Apr 18 19:46:35 2004
> @@ -55,7 +55,7 @@
>  			continue;
>  
>  		cpu_buf = &cpu_buffer[i]; 
> -		snprintf(buf, 6, "cpu%d", i);
> +		snprintf(buf, 10, "cpu%d", i);
>  		cpudir = oprofilefs_mkdir(sb, dir, buf);
>   
>  		/* Strictly speaking access to these ulongs is racy,

Andrew, can you apply this patch ?

regards,
Phil
