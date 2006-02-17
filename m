Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWBQALe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWBQALe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWBQALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:11:34 -0500
Received: from xenotime.net ([66.160.160.81]:26282 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750827AbWBQALd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:11:33 -0500
Date: Thu, 16 Feb 2006 16:11:32 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc3-git5: drivers/acpi/osl.c:57:38: empty filename in
 #include
In-Reply-To: <20060217000525.GD4422@stusta.de>
Message-ID: <Pine.LNX.4.58.0602161609070.25305@shark.he.net>
References: <43F3B553.2010506@ribosome.natur.cuni.cz> <20060217000525.GD4422@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Adrian Bunk wrote:

> On Thu, Feb 16, 2006 at 12:12:19AM +0100, Martin MOKREJ? wrote:
>
> > Hi,
>
> Hi Martin,
>
> >   I have the following problem when compiling linux kernel on Intel
> > Pentium4M machine:
> >
> > drivers/acpi/osl.c:57:38: empty filename in #include
> > drivers/acpi/osl.c: In function `acpi_os_table_override':
> > drivers/acpi/osl.c:258: error: `AmlCode' undeclared (first use in
> > this function)
> > drivers/acpi/osl.c:258: error: (Each undeclared identifier is
> > reported only once
> > drivers/acpi/osl.c:258: error: for each function it appears in.)
> > make[2]: *** [drivers/acpi/osl.o] Error 1
> >
> >   It turned out I have enabled the custom DSDT option but the field
> > for the custom file have left empty. That's the cause for the error.
> > Something should probably take care of this case. I use "menuconfig"
> > to manipulate the .config file.
>
> this is a class of errors Kconfig can't handle.
>
> And if it was handled, the next problems were to check first whether the
> file exists, and next whether it's actually a valid DSDT table file...
>
> Kconfig helps you to avoid many errors, but there are classes of errors
> it simply can't prevent.

Adrian, I looked at this one also, and I cannot find /AmlCode/
in any .h or .c file.  Did you find it?  if so, where?

thanks,
-- 
~Randy
