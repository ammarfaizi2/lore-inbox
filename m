Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbTAXLPh>; Fri, 24 Jan 2003 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267639AbTAXLPh>; Fri, 24 Jan 2003 06:15:37 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:65288 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267638AbTAXLPf>;
	Fri, 24 Jan 2003 06:15:35 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: srn@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: arch/ia64/sn/io/hcl.c debug bug 
In-reply-to: Your message of "Fri, 24 Jan 2003 10:25:03 BST."
             <200301241025.03955.philipp.marek@bmlv.gv.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Jan 2003 22:24:32 +1100
Message-ID: <7906.1043407472@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003 10:25:03 +0100, 
"Ph. Marek" <philipp.marek@bmlv.gv.at> wrote:
>Hello Bent, hi Ingo,
>I took this email-adresses as they are the 
>only ones in MAINTAINERS listed for an SGI.
>Sorry if I've told the wrong people.

Send arch/ia64/sn bugs to kaos@sgi.com, until we get an official SGI
maintainer assigned for the SNIA code in the kernel.  Thanks for
finding this bug.

>diff -u linux-2.5.59.orig/./arch/ia64/sn/io/hcl.c linux-2.5.59/./arch/ia64/sn/io/hcl.c
>-- linux-2.5.59.orig/./arch/ia64/sn/io/hcl.c       Fri Jan 24 10:19:44 2003
>+++ linux-2.5.59/./arch/ia64/sn/io/hcl.c   Fri Jan 24 10:19:46 2003
>@@ -1257,7 +1257,7 @@
>         * It does not make any sense to call this on vertexes with multiple
>         * inventory structs chained together
>         */
>-       if ( device_inventory_get_next(device, &invplace) != NULL ) {
>+       if ( device_inventory_get_next(device, &invplace) != NULL )
>                printk("Should panic here ... !\n");
> #endif
>        return (val);

