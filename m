Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTBIUHV>; Sun, 9 Feb 2003 15:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTBIUHV>; Sun, 9 Feb 2003 15:07:21 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:1299 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267431AbTBIUHU>; Sun, 9 Feb 2003 15:07:20 -0500
Date: Sun, 9 Feb 2003 20:17:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Switch kernel/sysctl.c to use C99 initializers
Message-ID: <20030209201704.B7704@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Art Haas <ahaas@airmail.net>, linux-kernel@vger.kernel.org
References: <20030208005753.GA4386@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030208005753.GA4386@debian>; from ahaas@airmail.net on Fri, Feb 07, 2003 at 06:57:53PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 06:57:53PM -0600, Art Haas wrote:
> --- 1.37/kernel/sysctl.c	Thu Dec  5 10:06:54 2002
> +++ edited/sysctl.c	Fri Feb  7 18:12:14 2003
> @@ -147,121 +147,458 @@
>  /* The default sysctl tables: */
>  
>  static ctl_table root_table[] = {
> -	{CTL_KERN, "kernel", NULL, 0, 0555, kern_table},
> -	{CTL_VM, "vm", NULL, 0, 0555, vm_table},
> +	{
> +		.ctl_name	= CTL_KERN,
> +		.procname	= "kernel",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0555,
> +		.child		= kern_table

I don't think this makes the code more readable..

