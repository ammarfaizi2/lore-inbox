Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTICTWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTICTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:21:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31668 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264356AbTICTVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:21:25 -0400
Message-ID: <3F563F01.3030207@watson.ibm.com>
Date: Wed, 03 Sep 2003 15:20:33 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ckrm-tech@lists.sourceforge.net, niwa.hideyuki@soft.fujitsu.com
Subject: Re: [RFC] Class-based Kernel Resource Management
References: <1062186708.15245.832.camel@elinux05.watson.ibm.com> <20030903105409.0c341574.niwa.hideyuki@soft.fujitsu.com>
In-Reply-To: <20030903105409.0c341574.niwa.hideyuki@soft.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NIWA Hideyuki wrote:

> Hello.
> 
> I tried ckrm (Class-based Kernel Resource Management) patch. 
> I am very interested in ckrm. 

Thanks for your interest and feedback.

> However, I found the following problems. 
> 
> 1) Both of ckcpu and ckmem could not be applied at the same time. 
>  I corrected the patch by hand. 
>  Is it impossible to use both at the same time?

No, it is the intent of the project to have all four controllers cpu, memory,
io and network to be usable simultaneously.

However, the supplied patches for each controller only assume the core patch
(ckcore) to have been applied. We'll try to provide rollups of all controllers
combined on the ckrm site once the combinations get tested (if you do that, please let us
know !)


> 2) When rbcemod of the module is compiled, "ckrm_cpu_change_class" 
>    becomes an undeclared symbol. 
> 
>  I modified kernel source kernel/class.c and export "ckrm_cpu_change_class": 
>         EXPORT_SYMBOL(ckrm_cpu_change_class);

Thanks. I'll add it to the next version.

> 3) The bash process newly executed dies one after another when rbadmin 
>    is executed.
> 
>  The value of the argument "cls" of the "ckrm_cpu_change_class" 
>  function might be NULL. 
>  Therefore, the NULL pointer dereference occurs when it 
>  starts changing the class of the bash process. 

Will check this out.


-Shailabh

