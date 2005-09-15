Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVIOH6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVIOH6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIOH6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:58:36 -0400
Received: from web51001.mail.yahoo.com ([206.190.38.132]:23971 "HELO
	web51001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750767AbVIOH6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:58:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s3EvO+ht+ZqbYPFSLZEddRuL0dB3onS+AC3/IH+UtFM7W34hRSPz+gVtVfpQ0TkQn3abjzLtGpWTy3bptamGPfxpwuPGT338NcqFKBSJZzTkaGMNhmQGiCE6nQqxtU0X/XFP9Op3Jtp7pLNvyO7CU0lp44IT4JD8aj4pbxyxn/c=  ;
Message-ID: <20050915075801.13000.qmail@web51001.mail.yahoo.com>
Date: Thu, 15 Sep 2005 00:58:00 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: chriswhite@gentoo.org, marekw1977@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509151753.21971.chriswhite@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Something that can do the hardware detection, then
> maps that to drivers
> > would be very useful.
> 
> well, in theory this works as well.  If you do this
> in the kernel source 

> directory:
> 
> make allmodconfig
> 
> that makes a kernel with all possible configure
> options that can be built as 
> modules enabled.
> 
> make install
> 
> and you have a couple of nice files in
> /lib/modules/(version)/modules.*map
> 
> -rw-r--r--  1 root root    73 Sep 14 23:15
> modules.ieee1394map
> -rw-r--r--  1 root root   132 Sep 14 23:15
> modules.inputmap
> -rw-r--r--  1 root root    81 Sep 14 23:15
> modules.isapnpmap
> -rw-r--r--  1 root root  7834 Sep 14 23:15
> modules.pcimap
> -rw-r--r--  1 root root    43 Sep 14 23:15
> modules.seriomap
> -rw-r--r--  1 root root 80010 Sep 14 23:15
> modules.usbmap
> 
> the usual favorite of mine is modules.pcimap, which,
> when compined with lspci 
> can give you the proper module for your pci device. 
> Granted it has the fault 
> of a) how to figure out the configure option. 
> Sometimes it's CONFIG_[name], 
> sometimes it's not (grepping maybe?)

For that reason I thought the best way is: using the
option-name given out, by make menuconfig or make
config... And you can even easily upgraded it if the
option-name(for the same Hardware) is changed by a new
Kernel. By only putting this new option-name in the
rules_list with the same rule.   

 b) sometimes
> two drivers do the same 
> thing, but if enabled together will cause kittens to
> cry and babies to pull 
> flowers.  Therein lies one of the main issues.  I'm
> going to assume by seeing 
> the rules_file bit that you address it in that way. 
> However, seeing the 
> development model of the kernel, trying to keep that
> updated may get a little 
> weird.  

Yes your right. The idea(eventhuogh it is a dream) is
that, this Framework might be hopefully in the future,
a part of the Kernel. So it can be updated everytime
before a new Kernel will be releases. 

> My 1.5 $denomination
> Chris White
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
