Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUKULNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUKULNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUKULNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:13:06 -0500
Received: from mail.math.uni-mannheim.de ([134.155.89.179]:58617 "EHLO
	mail.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261576AbUKULND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:13:03 -0500
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: [PATCH] sr module_param conversion
Date: Sun, 21 Nov 2004 12:13:38 +0100
User-Agent: KMail/1.7.1
References: <41969B65.9000807@ppp0.net>
In-Reply-To: <41969B65.9000807@ppp0.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411211213.38129@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> module_param conversion for SCSI cdrom driver
>
> Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>

> diff -Nru a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
> --- a/drivers/scsi/sr_ioctl.c	2004-11-14 00:36:56 +01:00
> +++ b/drivers/scsi/sr_ioctl.c	2004-11-14 00:36:56 +01:00
> @@ -29,6 +29,9 @@
>   * It is off by default and can be turned on with this module parameter */
>  static int xa_test = 0;
>
> +module_param(xa_test, int, S_IRUGO | S_IWUSR);
> +
> +

I think it should be "bool" instead of "int". And one newline should be
enough for everyone.

You should CC linux-scsi@vger.kernel.org and James Bottomley
<James.Bottomley@steeleye.com> to get this applied.

Eike
