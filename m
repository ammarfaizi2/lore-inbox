Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRF2CTS>; Thu, 28 Jun 2001 22:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbRF2CTI>; Thu, 28 Jun 2001 22:19:08 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:33028 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265402AbRF2CS4>;
	Thu, 28 Jun 2001 22:18:56 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: scole@lanl.gov
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac20 problems with drivers/net/Config.in and make xconfig 
In-Reply-To: Your message of "Thu, 28 Jun 2001 10:05:58 CST."
             <01062810055901.01131@spc.esa.lanl.gov> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jun 2001 12:18:50 +1000
Message-ID: <16590.993781130@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 10:05:58 -0600, 
Steven Cole <scole@lanl.gov> wrote:
>[root@spc linux]# make xconfig
>./tkparse < ../arch/i386/config.in >> kconfig.tk
>make[1]: *** [kconfig.tk] Error 139
>make[1]: Leaving directory `/usr/src/linux-2.4.5-ac20/scripts'

Sigh.  I wish people making big changes to config files would check
that the change works for all the variants of make *config.

Index: 5.52/drivers/net/Config.in
--- 5.52/drivers/net/Config.in Fri, 29 Jun 2001 11:39:55 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.4.1.12 644)
+++ 5.52(w)/drivers/net/Config.in Fri, 29 Jun 2001 12:14:23 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.4.1.12 644)
@@ -16,7 +16,7 @@ if [ "$CONFIG_EXPERIMENTAL" = "y" ]; the
 fi
 
 if [ "$CONFIG_ISAPNP" = "y" ]; then
-   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000 $CONFIG_ISAPNP
+   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000
 fi
 
 #
@@ -204,7 +204,6 @@ bool 'Ethernet (10 or 100Mbit)' CONFIG_N
       dep_tristate '    D-Link DE600 pocket adapter support' CONFIG_DE600 $CONFIG_ISA
       dep_tristate '    D-Link DE620 pocket adapter support' CONFIG_DE620 $CONFIG_ISA
    fi
-fi
 
 endmenu
 

