Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSIOXHq>; Sun, 15 Sep 2002 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSIOXHq>; Sun, 15 Sep 2002 19:07:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318302AbSIOXHo>;
	Sun, 15 Sep 2002 19:07:44 -0400
Message-ID: <3D8513C9.2030709@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:12:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151839190.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> Hello Linus,
> New I2C drivers that have been adjusted after Russell King comments of August.
> o i2c-algo-8xx.c
> o i2c-pport.c
> o i2c-adap-ibm_ocp.c
> o i2c-pcf-epp.c
> o Add new drivers to Config.in and Makefile.
> o Add new drivers to i2c-core for initialization.
> o Remove EXPORT_NO_SYMBOLS statement from i2c-dev, i2c-elektor and i2c-frodo.
> o Cleanup init_module and cleanup_module adding __init and __exit to most drivers.
> o Adjust i2c-elektor with cli/sti replacement.
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux/drivers/i2c/i2c-dev.c.orig	2002-09-05 11:23:38.000000000 -0400
> +++ linux-2.5.34/drivers/i2c/i2c-dev.c	2002-09-05 11:25:21.000000000 -0400
> @@ -544,8 +544,6 @@
>  	return 0;
>  }
>  
> -EXPORT_NO_SYMBOLS;
> -
>  #ifdef MODULE

kill ifdef


>  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
> --- linux/drivers/i2c/i2c-elektor.c.orig	2002-09-10 22:31:34.000000000 -0400
> +++ linux-2.5.34/drivers/i2c/i2c-elektor.c	2002-09-10 22:31:58.000000000 -0400
> @@ -291,8 +291,6 @@
>  	return 0;
>  }
>  
> -EXPORT_NO_SYMBOLS;
> -
>  #ifdef MODULE
>  MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
>  MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");

kill ifdef


> --- linux/drivers/i2c/i2c-frodo.c.orig	2002-09-05 11:23:59.000000000 -0400
> +++ linux-2.5.34/drivers/i2c/i2c-frodo.c	2002-09-05 11:25:28.000000000 -0400
> @@ -97,8 +97,6 @@
>  	return (i2c_bit_add_bus (&frodo_ops));
>  }
>  
> -EXPORT_NO_SYMBOLS;
> -
>  static void __exit i2c_frodo_exit (void)
>  {
>  	i2c_bit_del_bus (&frodo_ops);
> @@ -111,8 +109,6 @@
>  MODULE_LICENSE ("GPL");
>  #endif	/* #ifdef MODULE_LICENSE */

kill MODULE_LICENSE ifdef


>  
> -EXPORT_NO_SYMBOLS;
> -
>  module_init (i2c_frodo_init);
>  module_exit (i2c_frodo_exit);
>  


