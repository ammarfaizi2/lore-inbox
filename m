Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUIWCKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUIWCKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 22:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUIWCKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 22:10:45 -0400
Received: from ozlabs.org ([203.10.76.45]:57557 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268146AbUIWCJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 22:09:47 -0400
Date: Thu, 23 Sep 2004 10:17:54 +1000
From: Anton Blanchard <anton@samba.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       amodra@bigpond.net.au
Subject: Re: 2.6.8 link failure for powerpc-970?
Message-ID: <20040923001754.GB2825@krispykreme>
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095669339.2800.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> use this patch
> --- linux-2.6.8/arch/ppc64/Makefile~    2004-09-03 13:02:48.372244432
> +0200
> +++ linux-2.6.8/arch/ppc64/Makefile     2004-09-03 13:02:48.372244432
> +0200
> @@ -28,5 +28,7 @@
>  LDFLAGS_vmlinux        := -Bstatic -e $(KERNELLOAD) -Ttext
> $(KERNELLOAD)
>  CFLAGS         += -msoft-float -pipe -mminimal-toc -mtraceback=none
> +
> +CFLAGS += $(call cc-option,-mcall-aixdesc)

We shouldnt need this with the two recent patches from Alan Modra
(add -synthetic to nm in arch/ppc64/Makefile and add an opd section
in the ppc64 vmlinux.lds).

Anton
