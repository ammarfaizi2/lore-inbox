Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWFSJmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWFSJmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWFSJmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:42:49 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:7054 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932220AbWFSJms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:42:48 -0400
Date: Mon, 19 Jun 2006 11:42:46 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "leo.liang.chen@gmail.com" <leo.liang.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Newbie questions on the kernel programming
Message-ID: <20060619094245.GA13787@harddisk-recovery.com>
References: <1150709412.051278.100900@g10g2000cwb.googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150709412.051278.100900@g10g2000cwb.googlegroups.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 09:30:12AM -0000, leo.liang.chen@gmail.com wrote:
> I am learning linux kernel programming starting from  "The Linux Kernel
> Module Programming Guide"(http://www.faqs.org/docs/kernel/) .   I have
> background in Windows DDK, but I am confused on the following topics.
> Can anyone here give me some hints.
> 
> 1) MODULE_PARM() macro (http://www.faqs.org/docs/kernel/x350.html)
> static short int myshort = 1;
> static int myint = 420;
> static long int mylong = 9999;
> static char *mystring = "blah";
> 
> MODULE_PARM (myshort, "h");
> MODULE_PARM (myint, "i");
> MODULE_PARM (mylong, "l");
> MODULE_PARM (mystring, "s");

Note that this is an obsolete syntax, it changed in 2.6 like this:

  module_param(myint, int, 0);

> In the sample code, it is said the MODULE_PARM macro can allow
> arguments to be passed to the driver module.  But how?

  modprobe mydriver myshort=42

> 2) Character Device Drivers(http://www.faqs.org/docs/kernel/x571.html)
> I can not catch the key points in this section.  What should I learn
> from the "chardev.c" sample?  How can I install the module as a device?
>  How can I call the functions in the driver?
> 
> 3)  The /proc File System(http://www.faqs.org/docs/kernel/x716.html)
> What's the main points in the section.  How does the /proc file system
> matter linux kernel programming?

Hardly at all anymore.

See http://lwn.net/Kernel/LDD3/ for a book that describes the current
2.6 kernel.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
