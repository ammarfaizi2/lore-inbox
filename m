Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUEVBhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUEVBhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUEUXjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:39:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:14028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264645AbUEUXSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:18:10 -0400
Date: Fri, 21 May 2004 16:20:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-Id: <20040521162044.7ad42db2.akpm@osdl.org>
In-Reply-To: <20040521100734.GA31550@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +	{
> +		extern char swsusp_pg_dir[PAGE_SIZE];
> +		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
> +	}
> +#endif

Please move the declaration of swsusp_pg_dir[] to a header file where it is
visible to both the users and the definition site, then resend.  Thanks.
