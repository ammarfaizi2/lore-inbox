Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUBTVpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUBTVpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:45:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42473 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261365AbUBTVpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:45:30 -0500
Message-ID: <40367FC8.2020802@us.ibm.com>
Date: Fri, 20 Feb 2004 15:44:40 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Greg KH <greg@kroah.com>, Mike Anderson <andmike@us.ibm.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       kai@germaschewski.name, sam@ravnborg.org, akpm@osdl.org
Subject: Re: Question on MODULE_VERSION macro
References: <20040120082232.C9AFE2C290@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any update on the MODULE_VERSION macro getting into mainline?

-Brian


Rusty Russell wrote:
> In message <20040120011734.GB6309@kroah.com> you write:
> 
>>On Tue, Jan 20, 2004 at 11:57:38AM +1100, Rusty Russell wrote:
>>
>>>In message <20040119214233.GF967@beaverton.ibm.com> you write:
>>>
>>>>Rusty,
>>>>	Christoph mentioned that a MODULE_VERSION macro may be pending.
>>>
>>>Hey, thanks Christoph for the reminder.  I stopped when we were
>>>frozen.
>>>
>>>This still seems to apply.  Do people think this is huge overkill, or
>>>a work of obvious beauty and genius?
>>
>>Looks sane.  I'm guessing that modinfo can show this?
> 
> 
> Yes.  Looks like so:
> 
> --- working-2.6.1-bk5-module_version/arch/i386/kernel/apm.c.~1~	2003-09-29 10:25:15.000000000 +1000
> +++ working-2.6.1-bk5-module_version/arch/i386/kernel/apm.c	2004-01-20 18:22:46.000000000 +1100
> @@ -2081,3 +2081,4 @@
>  MODULE_PARM_DESC(smp,
>  	"Set this to enable APM use on an SMP platform. Use with caution on older systems");
>  MODULE_ALIAS_MISCDEV(APM_MINOR_DEV);
> +MODULE_VERSION("1.16ac-rustytest");
> 
> $ modinfo arch/i386/kernel/apm.ko
> author:         Stephen Rothwell
> description:    Advanced Power Management
> license:        GPL
> ....
> version:        1.16ac-rustytest B13E9451C4CA3B89577DEFF
> vermagic:       2.6.1-bk5 SMP PENTIUMII gcc-3.2
> depends:        
> 
> Thanks,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

