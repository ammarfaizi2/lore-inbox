Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136540AbRAIAS0>; Mon, 8 Jan 2001 19:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136421AbRAIASG>; Mon, 8 Jan 2001 19:18:06 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:43517 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129387AbRAIAR4>; Mon, 8 Jan 2001 19:17:56 -0500
Date: Mon, 8 Jan 2001 20:30:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Drew Eckhardt <drew@PoohSticks.ORG>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tidy 53c7,8xx.c was Re: [PATCH] de620.c: nitpicking
Message-ID: <20010108203002.H17087@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Drew Eckhardt <drew@PoohSticks.ORG>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108202533.F17087@conectiva.com.br>; from acme@conectiva.com.br on Mon, Jan 08, 2001 at 08:25:33PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ouch, sorry for the misleading subject, cut and paste sometimes doesn't work ;(

Em Mon, Jan 08, 2001 at 08:25:33PM -0200, Arnaldo Carvalho de Melo escreveu:
> Hi,
> 
> 	Please consider applying, no need to restore_flags here, as it is
> restored in the beginning of this if block.
> 
> - Arnaldo
> 
> 
> --- linux-2.4.0-ac3/drivers/scsi/53c7,8xx.c	Fri Oct 13 18:40:51 2000
> +++ linux-2.4.0-ac3.acme/drivers/scsi/53c7,8xx.c	Mon Jan  8 20:24:35 2001
> @@ -1899,7 +1899,6 @@
>  		hostdata->script, start);
>  	    printk ("scsi%d : DSPS = 0x%x\n", host->host_no,
>  		NCR53c7x0_read32(DSPS_REG));
> -	    restore_flags(flags);
>  	    return -1;
>  	}
>      	hostdata->test_running = 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
