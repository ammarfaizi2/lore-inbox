Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWCWAbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWCWAbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWCWAbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:31:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51158 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932686AbWCWAbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:31:10 -0500
Message-ID: <4421EC44.7010500@us.ibm.com>
Date: Wed, 22 Mar 2006 18:31:00 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: Andi Kleen <ak@suse.de>, Xen-devel <xen-devel@lists.xensource.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Chris Wright <chrisw@osdl.org>, Christopher Li <chrisl@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Anne Holler <anne@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Jyothy Reddy <jreddy@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>	<200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org>
In-Reply-To: <20060322214025.GJ15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
>   
>> The disassembly stuff indeed doesn't look like something
>> that belongs in the kernel.
>>     
>
> Strongly agreed.  The strict ABI requirements put forth here are not
> in-line with Linux, IMO.  I think source compatibility is the limit of
> reasonable, and any ROM code be in-tree if something like this were to
> be viable upstream.
>   

Hi Chris,

Would you have less trouble if the "ROM" were actually more like a 
module?  Specifically, if it had a proper elf header and symbol table, 
used symbols as entry points, and was a GPL interface (so that ROM's had 
to be GPL)?  Then it's just a kernel module that's hidden in the option 
ROM space and has a C interface.

I know you end up losing the ability to do crazy inlining of the ROM 
code but I think it becomes a much less hairy interface that way.

Regards,

Anthony Liguori

> thanks,
> -chris
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization
>   

