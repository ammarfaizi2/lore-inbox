Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbUKKAem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbUKKAem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUKKAem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:34:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:14034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262155AbUKKAef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:34:35 -0500
Date: Wed, 10 Nov 2004 16:38:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
Message-Id: <20041110163839.298380f8.akpm@osdl.org>
In-Reply-To: <4192A959.9020806@conectiva.com.br>
References: <4192A959.9020806@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
>
> --- 1.116/arch/i386/kernel/io_apic.c	2004-10-28 05:35:33 -03:00
> +++ edited/arch/i386/kernel/io_apic.c	2004-11-10 21:39:57 -02:00
> @@ -1039,6 +1039,8 @@
>  	return MPBIOS_trigger(idx);
>  }
>  
> +extern int (*platform_rename_gsi)(int ioapic, int gsi);

This defeats compiler typechecking.  Please place extern declarations in
header files where they are visible to the definition and to all users.
