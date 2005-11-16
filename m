Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbVKPTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbVKPTwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbVKPTwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:52:20 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:49029 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030456AbVKPTwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:52:19 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
Subject: Re: [RESEND] [PATCH] drivers/acpi/asus_acpi.c unsigned comparison
Date: Wed, 16 Nov 2005 12:52:08 -0700
User-Agent: KMail/1.8.2
Cc: sziwan@users.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       Karol Kozimor <sziwan@users.sourceforge.net>,
       Julien Lerouge <julien.lerouge@free.fr>,
       acpi4asus-user@lists.sourceforge.net
References: <200511121616.14940.ace@staticwave.ca>
In-Reply-To: <200511121616.14940.ace@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161252.08927.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 2:16 pm, Gabriel A. Devenyi wrote:
> It helps if I attach the patch.

And send it to the right places (copied, from MAINTAINERS).

> proc_write_brn, and proc_write_disp both use a parameter "count" to store the result from parse_arg.
> The return of parse_arg is an int, but count is declared as an unsigned int, and later checked versus zero,
> which is meaningless. This patch fixes the declaration of count in both functions.
> 
> Thanks to LinuxICC (http://linuxicc.sf.net)
> 
> Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>
> 
> diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
> index fec895a..9dfd0cd 100644
> --- a/drivers/acpi/asus_acpi.c
> +++ b/drivers/acpi/asus_acpi.c
> @@ -748,7 +748,7 @@ proc_read_brn(char *page, char **start, 
>  
>  static int
>  proc_write_brn(struct file *file, const char __user * buffer,
> -	       unsigned long count, void *data)
> +	       long count, void *data)
>  {
>  	int value;
>  
> @@ -798,7 +798,7 @@ proc_read_disp(char *page, char **start,
>   */
>  static int
>  proc_write_disp(struct file *file, const char __user * buffer,
> -		unsigned long count, void *data)
> +		long count, void *data)
>  {
>  	int value;
>  
> 
> 
> -- 
> Gabriel A. Devenyi
> ace@staticwave.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
