Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWEJRKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWEJRKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWEJRKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:10:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:60848 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964929AbWEJRKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:10:16 -0400
Subject: Re: [PATCH -mm] tpm_register_hardware gcc 4.1 warning fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200605100256.k4A2u88J031785@dwalker1.mvista.com>
References: <200605100256.k4A2u88J031785@dwalker1.mvista.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 12:08:37 -0500
Message-Id: <1147280918.29414.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack'ed by: Kylene Hall <kjhall@us.ibm.com>

On Tue, 2006-05-09 at 19:56 -0700, Daniel Walker wrote:
> Fixes the following warning,
> 
> drivers/char/tpm/tpm.c: In function 'tpm_register_hardware':
> drivers/char/tpm/tpm.c:1157: warning: assignment from incompatible pointer type
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/drivers/char/tpm/tpm.h
> ===================================================================
> --- linux-2.6.16.orig/drivers/char/tpm/tpm.h
> +++ linux-2.6.16/drivers/char/tpm/tpm.h
> @@ -140,7 +140,7 @@ extern int tpm_pm_resume(struct device *
>  extern struct dentry ** tpm_bios_log_setup(char *);
>  extern void tpm_bios_log_teardown(struct dentry **);
>  #else
> -static inline struct dentry* tpm_bios_log_setup(char *name)
> +static inline struct dentry ** tpm_bios_log_setup(char *name)
>  {
>  	return NULL;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

