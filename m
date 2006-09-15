Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWIOWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWIOWqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWIOWqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:46:39 -0400
Received: from xenotime.net ([66.160.160.81]:40365 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932344AbWIOWqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:46:38 -0400
Date: Fri, 15 Sep 2006 15:47:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, rossb@google.com,
       akpm@google.com, sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to
 -mm tree
Message-Id: <20060915154752.d7bdb8a0.rdunlap@xenotime.net>
In-Reply-To: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 14:58:06 -0700 akpm@osdl.org wrote:

> 
> The patch titled
> 
>      allow /proc/config.gz to be built as a module
> 
> has been added to the -mm tree.  Its filename is
> 
>      allow-proc-configgz-to-be-built-as-a-module.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: allow /proc/config.gz to be built as a module
> From: Ross Biro <rossb@google.com>

When/where was this patch submitted?  I seem to have missed it
(or it was so long ago that I forgot about it).

> The driver for /proc/config.gz consumes rather a lot of memory and it is in
> fact possible to build it as a module.

Can you try to quantify "rather a lot of memory"?

> In some ways this is a bit risky, because the .config which is used for
> compiling kernel/configs.c isn't necessarily the same as the .config which was
> used to build vmlinux.

and that's why a module wasn't allowed.
It's not worth the risk IMO.

> But OTOH the potential memory savings are decent, and it'd be fairly dumb to
> build your configs.o with a different .config.
> 
> Signed-off-by: Andrew Morton <akpm@google.com>
> Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  init/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN init/Kconfig~allow-proc-configgz-to-be-built-as-a-module init/Kconfig
> --- a/init/Kconfig~allow-proc-configgz-to-be-built-as-a-module
> +++ a/init/Kconfig
> @@ -241,7 +241,7 @@ config AUDITSYSCALL
>  	  ensure that INOTIFY is configured.
>  
>  config IKCONFIG
> -	bool "Kernel .config support"
> +	tristate "Kernel .config support"
>  	---help---
>  	  This option enables the complete Linux kernel ".config" file
>  	  contents to be saved in the kernel. It provides documentation
> _

---
~Randy
