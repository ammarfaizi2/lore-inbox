Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSLJPZC>; Tue, 10 Dec 2002 10:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSLJPZB>; Tue, 10 Dec 2002 10:25:01 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:24511 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262322AbSLJPYD>; Tue, 10 Dec 2002 10:24:03 -0500
Subject: Re: [PATCH 2.4.20-BK] make new ide compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210154904.E18849@deep-space-9.dsnet>
References: <20021210154904.E18849@deep-space-9.dsnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 16:07:00 +0000
Message-Id: <1039536420.14166.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 14:49, Stelian Pop wrote:
> ===== include/linux/ide.h 1.7 vs edited =====
> --- 1.7/include/linux/ide.h	Fri Nov 29 23:03:01 2002
> +++ edited/include/linux/ide.h	Tue Dec 10 12:20:01 2002
> @@ -1755,5 +1755,8 @@
>  #define ide_lock		(io_request_lock)
>  #define DRIVE_LOCK(drive)       ((drive)->queue.queue_lock)
>  
> +#define local_save_flags(flags)	save_flags((flags))
> +#define save_and_cli(x)		local_irq_save(x)
> +#define local_irq_set(flags)    do { local_save_flags((flags)); local_irq_enable(); } while (0)
>  

Please don't apply these changes. Use the ones from -ac

