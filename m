Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271141AbSISPJj>; Thu, 19 Sep 2002 11:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271162AbSISPJj>; Thu, 19 Sep 2002 11:09:39 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:18082 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271141AbSISPJW>; Thu, 19 Sep 2002 11:09:22 -0400
Date: Thu, 19 Sep 2002 17:12:25 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac2
Message-ID: <20020919171225.B8998@brodo.de>
References: <20020919104233.A1812@brodo.de> <Pine.NEB.4.44.0209191106370.15721-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.NEB.4.44.0209191106370.15721-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Thu, Sep 19, 2002 at 11:07:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:07:33AM +0200, Adrian Bunk wrote:
> On Thu, 19 Sep 2002, Dominik Brodowski wrote:
> 
> > Not really CPUfreq related, but this should fix it:
> >...
> 
> Unfortunately not: 

OK, this should help (at least works here with your .config)

--- linux/include/asm-i386/hw_irq.h.original	Thu Sep 19 10:28:43 2002
+++ linux/include/asm-i386/hw_irq.h	Thu Sep 19 17:07:02 2002
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/smp_lock.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
 
