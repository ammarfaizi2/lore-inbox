Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946365AbWJSTTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946365AbWJSTTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946395AbWJSTTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:19:55 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:17096 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1946365AbWJSTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:19:54 -0400
Date: Thu, 19 Oct 2006 13:19:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: David KOENIG <karhudever@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] [PATCH] Replaced tty->driver_data lines with pci_get_drvdata(tty);
Message-ID: <20061019191953.GL2602@parisc-linux.org>
References: <4537CBE3.4080809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537CBE3.4080809@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 12:02:59PM -0700, David KOENIG wrote:
> +++ b/fs/compat_ioctl.c
> @@ -1270,7 +1270,7 @@ static int do_kdfontop_ioctl(unsigned in
>  		return -EPERM;
>  	op.data = compat_ptr(((struct console_font_op32 *)&op)->data);
>  	op.flags |= KD_FONT_FLAG_OLD;
> - -	vc = ((struct tty_struct *)file->private_data)->driver_data;
> +	vc = pci_get_drvdata((struct tty_struct *)file->private_data);

Did you even compile this?  pci_get_drvdata doesn't take a struct
tty_struct *, it takes a struct pci_dev *.
