Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVKNXsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVKNXsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVKNXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:48:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:12007 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932246AbVKNXsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:48:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Date: Tue, 15 Nov 2005 00:50:26 +0100
User-Agent: KMail/1.7.2
Cc: eranian@hpl.hp.com, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       stephane.eranian@hp.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net>
In-Reply-To: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511150050.27556.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 15 November 2005 00:30, akpm@osdl.org wrote:
> diff -puN include/asm-powerpc/unistd.h~perfmon2-reserve-system-calls include/asm-powerpc/unistd.h
> --- 25/include/asm-powerpc/unistd.h~perfmon2-reserve-system-calls       Mon Nov 14 15:27:32 2005
> +++ 25-akpm/include/asm-powerpc/unistd.h        Mon Nov 14 15:27:32 2005
> @@ -296,8 +296,20 @@
>  #define __NR_inotify_init      275
>  #define __NR_inotify_add_watch 276
>  #define __NR_inotify_rm_watch  277
> +#define __NR_pfm_create_context        278
> +#define __NR_pfm_write_pmcs    279
> +#define __NR_pfm_write_pmds    280
> +#define __NR_pfm_read_pmds     281
> +#define __NR_pfm_load_context  282
> +#define __NR_pfm_start         283
> +#define __NR_pfm_stop          284
> +#define __NR_pfm_restart       285
> +#define __NR_pfm_create_evtsets        286
> +#define __NR_pfm_getinfo_evtsets 287
> +#define __NR_pfm_delete_evtsets 288
> +#define __NR_pfm_unload_context        289
>  
> -#define __NR_syscalls          278
> +#define __NR_syscalls          290
>  
>  #ifdef __KERNEL__
>  #define __NR__exit __NR_exit

Hmm, I had sent an earlier patch to paulus that reserves 278 and
279 for spu_run and spu_create and that apparently got dropped.

Could I have those two numbers or is there already an established
user based for the perfmon2 numbers that would take preference?

	Arnd <><
