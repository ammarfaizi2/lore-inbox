Return-Path: <linux-kernel-owner+w=401wt.eu-S1752078AbXARRqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbXARRqf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 12:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXARRqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 12:46:35 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:34693 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752078AbXARRqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 12:46:34 -0500
Date: Thu, 18 Jan 2007 18:46:31 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: ak@suse.de, Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print number of oopses in Sysrq-P output
Message-ID: <20070118174631.GA16489@harddisk-recovery.com>
References: <20070118170522.GA23679@localhost.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118170522.GA23679@localhost.sw.ru>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 08:05:22PM +0300, Alexey Dobriyan wrote:
> From: Pavel Emelianov <xemul@openvz.org>
> 
> Useful in deciding whether said output should be ignored
> in absence of other info. :)
> 
> Signed-off-by: Pavel Emelianov <xemul@openvz.org>
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
> ---
> 
>  arch/i386/kernel/process.c   |    4 +++-
>  arch/i386/kernel/traps.c     |    2 +-
>  arch/x86_64/kernel/process.c |    6 ++++--
>  arch/x86_64/kernel/traps.c   |    3 ++-
>  4 files changed, 10 insertions(+), 5 deletions(-)

What about the other architectures?

> --- a/arch/i386/kernel/traps.c
> +++ b/arch/i386/kernel/traps.c
> @@ -366,6 +366,7 @@ int is_valid_bugaddr(unsigned long eip)
>  	return ud2 == 0x0b0f;
>  }
>  
> +int die_counter = 0;

Global variables don't have to be initialised at 0. They live in the
.bss segment so they will automatically initialised at 0 and not take
space in the kernel image.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
