Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264684AbTEaUMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTEaUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:12:14 -0400
Received: from [62.29.78.7] ([62.29.78.7]:17281 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264684AbTEaUMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:12:13 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: "Kevin P. Fleming" <kpfleming@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
Date: Sat, 31 May 2003 23:25:07 +0300
User-Agent: KMail/1.5.9
References: <3ED8D5E4.6030107@cox.net>
In-Reply-To: <3ED8D5E4.6030107@cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305312325.07809.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 19:18, Kevin P. Fleming wrote:
> Changes during 2.5.70 added _user tags to various bits in
> include/linux/sysctl.h. __user is defined in linux/compiler.h, which is
> included by linux/kernel.h but only if __KERNEL__ is defined. Compiliing
> uClibc against 2.5.70 fails because __user__ is not defined.
>
> Adding patch below solves the problem (yes, I know, userspace is not
> supposed to use kernel headers...)
>
> --- linux-2.5/include/linux/sysctl.h~	Sat May 31 08:52:49 2003
> +++ linux-2.5/include/linux/sysctl.h	Sat May 31 09:04:29 2003
> @@ -27,6 +27,7 @@
>   #include <linux/kernel.h>
>   #include <linux/types.h>
>   #include <linux/list.h>
> +#include <linux/compiler.h>
>
>   struct file;

linux/kernel.h includes <linux/compiler.h>.


Regards,
/ismail
