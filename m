Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTJTWrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTJTWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:47:45 -0400
Received: from crisium.vnl.com ([194.46.8.33]:40197 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S262659AbTJTWro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:47:44 -0400
Date: Mon, 20 Oct 2003 23:47:40 +0100
From: Dale Amon <amon@vnl.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Dale Amon <amon@vnl.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: CMD640 problem in 2.6.0-test8
Message-ID: <20031020224740.GA24438@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20031020172733.GA17379@vnl.com> <200310202056.42759.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310202056.42759.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 08:56:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> this patch should fix it,
> --bartlomiej

I had a bit of trouble with it caused by the cut and paste and ended up
just doing the edit manually. But it does the trick. Kernel compiles fine
now. Thanks.

> [IDE] fix drivers/ide/pci/cmd640.c for CONFIG_PCI=n
> 
> CMD640 driver also supports VLB version of the chipset, therefore fix
> drivers/ide/Makefile to include pci/ subdir even if CONFIG_BLK_DEV_IDEPCI=n.
> 
>  drivers/ide/Makefile |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/ide/Makefile~ide-cmd640-no_pci-fix drivers/ide/Makefile
> --- linux-2.6.0-test8/drivers/ide/Makefile~ide-cmd640-no_pci-fix	2003-10-20 20:47:03.701132024 +0200
> +++ linux-2.6.0-test8-root/drivers/ide/Makefile	2003-10-20 20:47:17.280067712 +0200
> @@ -8,7 +8,7 @@
>  # In the future, some of these should be built conditionally.
>  #
>  # First come modules that register themselves with the core
> -obj-$(CONFIG_BLK_DEV_IDEPCI)		+= pci/
> +obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
>  
>  # Core IDE code - must come before legacy
