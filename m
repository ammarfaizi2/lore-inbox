Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTDIPwM (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbTDIPwM (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:52:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35513 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263539AbTDIPwL convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 11:52:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Alistair Strachan <alistair@devzero.co.uk>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.67-mm1
Date: Wed, 9 Apr 2003 07:59:57 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200304081741.10129.alistair@devzero.co.uk> <200304081606.13405.pbadari@us.ibm.com> <200304090800.43022.alistair@devzero.co.uk>
In-Reply-To: <200304090800.43022.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304090859.57356.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 April 2003 12:00 am, Alistair Strachan wrote:

>
> Sorry for the delay, I've only just woken up. I applied the patch, it
> wouldn't compile, you missed the following (I think obvious) chunk:
>
> --- linux-2.5/fs/partitions/check.c.old 2003-04-09 07:49:29 +0100
> +++ linux-2.5/fs/partitions/check.c     2003-04-09 07:51:26 +0100
> @@ -160,7 +160,7 @@
>  {
>  #ifdef CONFIG_DEVFS_FS
>         devfs_handle_t dir;
> -       struct hd_struct *p = dev->part;
> +       struct hd_struct **p = dev->part;
>         char devname[16];
>
>         if (p[part-1]->de)
>
> With that in place, it compiled without warning and the machine now
> boots with the dynamic hd_struct work + aggregate stats patch.
>
> Thanks for your time.

Thank you for testing it with devfs. 

- Badari
