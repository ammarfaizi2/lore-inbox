Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbRGJLpv>; Tue, 10 Jul 2001 07:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbRGJLpl>; Tue, 10 Jul 2001 07:45:41 -0400
Received: from [213.98.126.44] ([213.98.126.44]:35076 "HELO trasno.org")
	by vger.kernel.org with SMTP id <S266220AbRGJLpe>;
	Tue, 10 Jul 2001 07:45:34 -0400
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.6-ac2] dmi_scan.c cleanups.
In-Reply-To: <20010709120814.D4850@come.alcove-fr>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20010709120814.D4850@come.alcove-fr>
Date: 10 Jul 2001 02:33:53 -0400
Message-ID: <m2n16duwby.fsf@anano.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "stelian" == Stelian Pop <stelian.pop@fr.alcove.com> writes:

Hi
        how about var args macros?

stelian> diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/arch/i386/kernel/dmi_scan.c linux-2.4.6-ac2/arch/i386/kernel/dmi_scan.c
stelian> --- linux-2.4.6-ac2.orig/arch/i386/kernel/dmi_scan.c	Mon Jul  9 10:25:52 2001
stelian> +++ linux-2.4.6-ac2/arch/i386/kernel/dmi_scan.c	Mon Jul  9 11:03:29 2001
stelian> @@ -14,8 +14,8 @@
stelian> u16	handle;
stelian> };
 
stelian> -#define dmi_printk(x)
stelian> -//#define dmi_printk(x) printk(x)
stelian> +#define dmi_printk while(0) printk
stelian> +//#define dmi_printk printk
 

#define dmp_printk(x...) printk(x)

once, here, put labels to the printks will be also a nice idea.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
