Return-Path: <linux-kernel-owner+w=401wt.eu-S965021AbWLMQmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWLMQmp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWLMQmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:42:44 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37616 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965021AbWLMQmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:42:43 -0500
Message-ID: <45802D80.60200@garzik.org>
Date: Wed, 13 Dec 2006 11:42:40 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] move SYS_HYPERVISOR inside the Generic Driver menu
References: <200610281859.k9SIxJu8024288@hera.kernel.org>
In-Reply-To: <200610281859.k9SIxJu8024288@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit eba6cd671427df295c10b54ee69cd5de419d38fe
> tree c92e5b59d5261a029a9e24b72b31eac70150cca1
> parent d7c3f5f231c60d7e6ada5770b536df2b3ec1bd08
> author Randy Dunlap <randy.dunlap@oracle.com> 1162057135 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> 1162060255 -0700
> 
> [PATCH] move SYS_HYPERVISOR inside the Generic Driver menu
> 
> Put SYS_HYPERVISOR inside the Generic Driver Config menu where it should
> be.  Otherwise xconfig displays it as a dangling (lost) menu item under
> Device Drivers, all by itself (when all options are displayed).
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: <holzheu@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/base/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 0b4e224..1429f3a 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -37,8 +37,8 @@ config DEBUG_DRIVER
>  
>  	  If you are unsure about this, say N here.
>  
> -endmenu
> -
>  config SYS_HYPERVISOR
>  	bool
>  	default n
> +
> +endmenu

I missed this when it went in.

The entire sum of code under this config option is so tiny, why not just 
make it unconditional?  Or depend on CONFIG_EMBEDDED.

	Jeff


