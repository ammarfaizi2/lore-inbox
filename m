Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275115AbRJJJJA>; Wed, 10 Oct 2001 05:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275120AbRJJJIu>; Wed, 10 Oct 2001 05:08:50 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58852
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S275115AbRJJJIm>; Wed, 10 Oct 2001 05:08:42 -0400
Date: Wed, 10 Oct 2001 11:09:05 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org,
        acme@conectiva.com.br
Subject: Re: Linux 2.4.10-ac10
Message-ID: <20011010110905.A28673@jaquet.dk>
In-Reply-To: <1002676545.5283.4.camel@thanatos> <Pine.NEB.4.40.0110101032320.28053-200000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.NEB.4.40.0110101032320.28053-200000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Wed, Oct 10, 2001 at 10:47:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 10:47:40AM +0200, Adrian Bunk wrote:
[...]
> 
> Yes, that was it. Sound works again for me after I've reversed the
> attached patch to drivers/sound/ad1816.c.

[...]

>  
> -	if (check_region (io_base, 16)) {
> -		printk ("ad1816: I/O port 0x%03x not free\n", io_base);
> -		return 0;
> +	if (request_region(io_base, 16, "AD1816 Sound")) {
> +		printk(KERN_WARNING "ad1816: I/O port 0x%03x not free\n",
> +				    io_base);
> +		goto err;
>  	}
>  

Would you mind trying with a '!' in front of the request_region call?

Regards,
  Rasmus
