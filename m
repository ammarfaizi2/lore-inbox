Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271252AbRHTOh6>; Mon, 20 Aug 2001 10:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271251AbRHTOht>; Mon, 20 Aug 2001 10:37:49 -0400
Received: from [209.38.98.99] ([209.38.98.99]:21214 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S271244AbRHTOhg>;
	Mon, 20 Aug 2001 10:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred Jackson <fred@arkansaswebs.com>
To: "WEB MASTER" <WEBADMIN@rect.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx won't recompile - fixed!
Date: Mon, 20 Aug 2001 09:31:24 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <812915418@rect.ernet.in>
In-Reply-To: <812915418@rect.ernet.in>
MIME-Version: 1.0
Message-Id: <01082009225902.01086@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, I fugured it out, and after reading about a host of similiar 
problems about includeing a '#include <linux/kernel.h>' as a fix, I 
wonder of some of the compilation issues are related.

RedHat 7.1 installs the kernel header files for the default kernel to 
the path /usr/include/linux/ during a workstation install (for what 
reason I don't know, either the setup is different for server install 
vs workstation install or the setup changed as of 7.1). These headers 
were used in compiling a different kernel, screwing up the whole damn 
thing- it's a miracle that I was even able to compile 2.4.6, 2.4.8, 
and 2.4.9 against the headers from 2.4.2-2.....

The error messages I recieved were relavent only in that 'parse 
error' was reported on lines containing 'FASTCALL('

Thanks 
Fred


_________________________________ 
On Saturday 18 August 2001 08:57 pm, WEB MASTER wrote:
> hi can u pls.. tell what the error exactly is ? vl 
> it seems u missed out the make dep step..
> check out the readme file..first
> sarvana.
> 
> > Hi ya,
> > 
> > I have a Redhat 7.1 system practically out of the box, and though 
I 
> > had no problem compiling 2.4.9 the first time around, I can't 
> > recompile it at all without deleting the directory and untaring 
the 
> > distribution again. 
> > 
> > any ideas?
> > 
> > thanks in advance!
> > 
> > Fred
> > 
> > I start with the usual 
> > make mrproper
> > make xconfig ( I load a kernel config file - originally created 
with 
> > 2.4.8) 
> > make bzImage
> > make modules
> > make modules_install
> > make install
> > 
> > (i've already edited lilo.conf and the links in the /boot 
directory)
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
________________________________________________________________________
> 
> Webmaster,REC Trichy               http://www.rect.edu 
> Computer Support Group             http://rangoli.rect.ernet.in   
> Tiruchirapalli-620001              webadmin@rect.ernet.in
> INDIA                              Phone: 91-431-552281
> 
========================================================================
>                               Dare to Dream
> 
------------------------------------------------------------------------
> 
