Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVCORmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVCORmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCORkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:40:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24850 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261656AbVCORjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:39:48 -0500
Date: Tue, 15 Mar 2005 18:39:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH][2.6.11] generic_serial.h gcc4 fix
Message-ID: <20050315173946.GR3189@stusta.de>
References: <16951.6077.612190.675720@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16951.6077.612190.675720@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 06:13:33PM +0100, Mikael Pettersson wrote:
> Fix
> 
> drivers/char/generic_serial.c:38: error: static declaration of 'gs_debug' follows non-static declaration
> include/linux/generic_serial.h:94: error: previous declaration of 'gs_debug' was here
> 
> compilation error from gcc4 in generic_serial.h.
> 
> /Mikael
> 
> --- linux-2.6.11/include/linux/generic_serial.h.~1~	2005-03-02 19:24:19.000000000 +0100
> +++ linux-2.6.11/include/linux/generic_serial.h	2005-03-15 17:11:07.000000000 +0100
> @@ -91,6 +91,4 @@ int  gs_setserial(struct gs_port *port, 
>  int  gs_getserial(struct gs_port *port, struct serial_struct __user *sp);
>  void gs_got_break(struct gs_port *port);
>  
> -extern int gs_debug;
> -
>  #endif

This patch is already in -mm for ages.

When doing such patches, -mm is usually a better basis than Linus' tree.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

