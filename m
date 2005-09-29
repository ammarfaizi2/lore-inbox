Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVI2Xqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVI2Xqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVI2Xqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:46:45 -0400
Received: from web34109.mail.mud.yahoo.com ([66.163.178.107]:3177 "HELO
	web34109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751395AbVI2Xqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:46:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Zxyhg1m1iJzTHlRBvw/YMBjcMW1mo+dc9iZK6DLksba2UXgVrV8ub7ScCW6/+++D/vekSBV/+HAZ3X+0IlNezR7Esqv5Fvj9fex39kLqMpunW49dCXDOzWzw18/a7Gwvf8emTG6LvF33RaPAQ4jT+11nA45qQ3pabDyx6uG0tMk=  ;
Message-ID: <20050929234641.26843.qmail@web34109.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 16:46:41 -0700 (PDT)
From: Wilson Li <yongshenglee@yahoo.com>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
To: Samuel Masham <Samuel.Masham@jp.sony.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Yamaguchi, Yohei" <Yohei.Yamaguchi@jp.sony.com>,
       Tim Bird <tim.bird@am.sony.com>
In-Reply-To: <200509291030.39024.Samuel.Masham@jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Samuel Masham <Samuel.Masham@jp.sony.com> wrote:

> I assume you are on a slow ppc32 platform.
> 
> The time taken is a function of the number of symbols, you can work
> around it 
> as shown in the patch below. Obviously this is just an example
> patch and is
> NOT signed off for anything but reading :)
> 
> I would really like do some work on a pre-link for modules but
> don't really know 
> where to start.
> 
> Any hints?
> 
> Samuel
> 
> ps Not subscribed, just  so please cc me
> 

Appreciate your help. 
I applied your patch manually since something was wrong during
patching. I guess we might not use same version of kernel. Mine is
2.6.8. 

But the function parse_args_reloc() still failed even though I have
passed a module param like elf_plt_info=1 during insmod. Here's the
command to load the module.

#>insmod mrbig.ko elf_plt_info=1

And console output is: 
init_module: consider insmod mrbig elf_plt_info=25,27,322144,160

I have no idea what the plt section is and what is going on in
module_frob_arch_sections() function. Any hints or documents I can
refer to?

Thanks,
Wilson Li




		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
