Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUGNTbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUGNTbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUGNTbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:31:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:2285 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265211AbUGNTba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:31:30 -0400
Subject: Re: [PATCH] pmac_zilog: initialize port spinlock on all init paths
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200407141709.i6EH9EYW029131@hera.kernel.org>
References: <200407141709.i6EH9EYW029131@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1089833270.11816.55.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jul 2004 14:27:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 11:25, Linux Kernel Mailing List wrote:
> ChangeSet 1.1853, 2004/07/14 09:25:57-07:00, eger@havoc.gtf.org

> diff -Nru a/arch/ppc/defconfig b/arch/ppc/defconfig
> --- a/arch/ppc/defconfig	2004-07-14 10:09:28 -07:00
> +++ b/arch/ppc/defconfig	2004-07-14 10:09:28 -07:00
> @@ -689,7 +689,7 @@
>  # Input Device Drivers
>  #
>  CONFIG_INPUT_KEYBOARD=y
> -CONFIG_KEYBOARD_ATKBD=y
> +# CONFIG_KEYBOARD_ATKBD is not set
>  # CONFIG_KEYBOARD_SUNKBD is not set
>  # CONFIG_KEYBOARD_LKKBD is not set
>  # CONFIG_KEYBOARD_XTKBD is not set
> @@ -724,8 +724,8 @@
>  #
>  # Non-8250 serial port support
>  #
> -CONFIG_SERIAL_CORE=y
> -CONFIG_SERIAL_PMACZILOG=y
> +# CONFIG_SERIAL_CORE is not set
> +# CONFIG_SERIAL_PMACZILOG is not set
>  # CONFIG_SERIAL_PMACZILOG_CONSOLE is not set
>  CONFIG_UNIX98_PTYS=y
>  CONFIG_LEGACY_PTYS=y

Hi, could we not disable AT keyboards (used by CHRP and PReP machines)
and PowerMac serial ports (used by PowerMacs) in the defconfig please?

-- 
Hollis Blanchard
IBM Linux Technology Center

