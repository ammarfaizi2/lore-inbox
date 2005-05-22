Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVEVG50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVEVG50 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 02:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVEVG50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 02:57:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261753AbVEVG5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 02:57:21 -0400
Date: Sun, 22 May 2005 02:57:09 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: minyard@acm.org
Subject: Re: [PATCH] Add sysfs support for the IPMI device interface
Message-ID: <20050522065709.GA31888@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	minyard@acm.org
References: <200505201511.j4KFBgHG002490@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505201511.j4KFBgHG002490@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 08:11:42AM -0700, Linux Kernel wrote:
 > tree e327b635e017dfcfd989b203c16ebd55e1d2526b
 > parent 45fed46f5b98aaf439e9ef125992ec853cd98499
 > author Corey Minyard <minyard@acm.org> Fri, 20 May 2005 08:56:23 +0200
 > committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri, 20 May 2005 21:58:04 -0700
 > 
 > [PATCH] Add sysfs support for the IPMI device interface
 > 
 > Add support for sysfs to the IPMI device interface.
 > 
 > Clean-ups based on Dimitry Torokovs comment by Philipp Hahn.
 > 

This doesn't compile..

drivers/char/ipmi/ipmi_devintf.c: In function 'ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:532: warning: passing argument 1 of 'class_simple_device_add' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function 'ipmi_smi_gone':
drivers/char/ipmi/ipmi_devintf.c:537: warning: passing argument 1 of 'class_simple_device_remove' makes integer from pointer without a cast
drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to function 'class_simple_device_remove'
drivers/char/ipmi/ipmi_devintf.c: In function 'init_ipmi_devintf':
drivers/char/ipmi/ipmi_devintf.c:558: warning: assignment from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:566: warning: passing argument 1 of 'class_simple_destroy' from incompatible
pointer type
drivers/char/ipmi/ipmi_devintf.c:580: warning: passing argument 1 of 'class_simple_destroy' from incompatible
pointer type
drivers/char/ipmi/ipmi_devintf.c: In function 'cleanup_ipmi':
drivers/char/ipmi/ipmi_devintf.c:591: warning: passing argument 1 of 'class_simple_destroy' from incompatible
pointer type
make[3]: *** [drivers/char/ipmi/ipmi_devintf.o] Error 1


		Dave

