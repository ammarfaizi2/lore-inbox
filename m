Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWEXW7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWEXW7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWEXW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:59:00 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56739 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751004AbWEXW67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:58:59 -0400
Date: Wed, 24 May 2006 18:58:45 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [PATCH 02/03] kexec: Avoid overwriting the current pgd (V2, i386)
Message-ID: <20060524225845.GB23291@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060524044232.14219.68240.sendpatchset@cherry.local> <20060524044242.14219.50618.sendpatchset@cherry.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524044242.14219.50618.sendpatchset@cherry.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 01:40:41PM +0900, Magnus Damm wrote:
>  
> @@ -170,45 +151,16 @@ void machine_kexec_cleanup(struct kimage
>  NORET_TYPE void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list;
> -	unsigned long reboot_code_buffer;
> -
> +	unsigned long control_code;
> +	unsigned long page_table_a;
>  	relocate_new_kernel_t rnk;
>  
> -	/* Interrupts aren't acceptable while we reboot */
> -	local_irq_disable();

Why are you getting rid of this call? Looks sane to disable interrupts
early.

Thanks
Vivek
