Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSKMONH>; Wed, 13 Nov 2002 09:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKMONH>; Wed, 13 Nov 2002 09:13:07 -0500
Received: from imail.ricis.com ([64.244.234.16]:3857 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S261640AbSKMONG>;
	Wed, 13 Nov 2002 09:13:06 -0500
Date: Wed, 13 Nov 2002 08:19:56 -0600
From: Lee Leahu <lee@ricis.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: allan.d@bigpond.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 - missing symbol from binfmt_aout built as a module
Message-Id: <20021113081956.1e33364b.lee@ricis.com>
In-Reply-To: <87fzugauqs.fsf@goat.bogus.local>
References: <3DC7AACD.2060909@bigpond.com>
	<87fzugauqs.fsf@goat.bogus.local>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is still broken is 2.5.47 as well.

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> scribbled something about Re: 2.5.46 - missing symbol from binfmt_aout built as a module:

> Allan Duncan <allan.d@bigpond.com> writes:
> 
> > A new glitch since 2.5.45.
> >
> >  From the "make modules_install":
> >
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
> > depmod: *** Unresolved symbols in /lib/modules/2.5.46/kernel/fs/binfmt_aout.o
> > depmod: 	ptrace_notify
> > make: *** [_modinst_post] Error 1
> 
> Regards, Olaf.
> 
> --- a/kernel/ksyms.c	Tue Nov  5 16:33:06 2002
> +++ b/kernel/ksyms.c	Tue Nov  5 16:36:40 2002
> @@ -53,6 +53,7 @@
>  #include <linux/percpu.h>
>  #include <linux/smp_lock.h>
>  #include <linux/dnotify.h>
> +#include <linux/ptrace.h>
>  #include <asm/checksum.h>
>  
>  #if defined(CONFIG_PROC_FS)
> @@ -492,6 +493,7 @@
>  #if !defined(__ia64__)
>  EXPORT_SYMBOL(loops_per_jiffy);
>  #endif
> +EXPORT_SYMBOL(ptrace_notify);
>  
>  
>  /* misc */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
