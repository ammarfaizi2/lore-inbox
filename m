Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423534AbWJaQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423534AbWJaQHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423533AbWJaQHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:07:31 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:21374 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423529AbWJaQHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:07:30 -0500
Date: Tue, 31 Oct 2006 08:02:35 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, adobriyan@gmail.com,
       ankita@in.ibm.com, vgoyal@in.ibm.com
Subject: Re: + lkdtm-module_param-fixes.patch added to -mm tree
Message-Id: <20061031080235.4f9948df.randy.dunlap@oracle.com>
In-Reply-To: <200610310837.k9V8bxII022722@shell0.pdx.osdl.net>
References: <200610310837.k9V8bxII022722@shell0.pdx.osdl.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 00:37:59 -0800 akpm@osdl.org wrote:

This patch is even cleaner:
http://lkml.org/lkml/2006/10/23/390

Did you drop it?  never see/have it?


> ------------------------------------------------------
> Subject: lkdtm: module_param fixes
> From: Andrew Morton <akpm@osdl.org>
> 
> A assume these permissions were a typo - Alexey's
> compile-time-check-re-world-writeable-module-params.patch catches it.
> 
> Fix a typo in the help string too.
> 
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Ankita Garg <ankita@in.ibm.com>
> Cc: Vivek Goyal <vgoyal@in.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/misc/lkdtm.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff -puN drivers/misc/lkdtm.c~lkdtm-module_param-fixes drivers/misc/lkdtm.c
> --- a/drivers/misc/lkdtm.c~lkdtm-module_param-fixes
> +++ a/drivers/misc/lkdtm.c
> @@ -116,14 +116,14 @@ static enum ctype cptype = NONE;
>  static int count = DEFAULT_COUNT;
>  
>  module_param(recur_count, int, 0644);
> -MODULE_PARM_DESC(recur_count, "Recurcion level for the stack overflow test,\
> +MODULE_PARM_DESC(recur_count, "Recursion level for the stack overflow test,\
>  				 default is 10");
>  module_param(cpoint_name, charp, 0644);
>  MODULE_PARM_DESC(cpoint_name, "Crash Point, where kernel is to be crashed");
> -module_param(cpoint_type, charp, 06444);
> +module_param(cpoint_type, charp, 0644);
>  MODULE_PARM_DESC(cpoint_type, "Crash Point Type, action to be taken on\
>  				hitting the crash point");
> -module_param(cpoint_count, int, 06444);
> +module_param(cpoint_count, int, 0644);
>  MODULE_PARM_DESC(cpoint_count, "Crash Point Count, number of times the \
>  				crash point is to be hit to trigger action");

---
~Randy
