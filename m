Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312315AbSCVMUF>; Fri, 22 Mar 2002 07:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312149AbSCVMTz>; Fri, 22 Mar 2002 07:19:55 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:55559 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S312315AbSCVMTt>;
	Fri, 22 Mar 2002 07:19:49 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Denis Zaitsev <zzz@cd-club.ru>
Date: Fri, 22 Mar 2002 13:17:04 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] matroxfb_base.c - not a so little patch
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2F43B06E5F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 02 at 16:47, Denis Zaitsev wrote:
> 
> The patch is against 2.5.5.  It seems that matroxfb_base.c is still
> the same since that time.  And I assume matroxfb_base.c with
> <if (var->bits_per_pixel == 4)> branch present, i.e. without my
> previous little fix.

Did you verified effects on generated code/data size? 

> +   for (p= &table[0].bpp; *p < bpp; p+= sizeof table[0]);
> +   var->red   .offset= *++p; var->red   .length= *++p;
> +   var->green .offset= *++p; var->green .length= *++p;
> +   var->blue  .offset= *++p; var->blue  .length= *++p;
> +   var->transp.offset= *++p; var->transp.length= *++p;

Please no. Access fields by their names, and do not assume anything
about padding.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
