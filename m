Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUBTTnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUBTTmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:42:50 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:51461 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261384AbUBTTiX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:38:23 -0500
Message-ID: <4036634F.2020406@kolumbus.fi>
Date: Fri, 20 Feb 2004 21:43:11 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
CC: Andreas Schwab <schwab@suse.de>, greg@kroah.com,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH]2.6.3-rc2 MSI Support for IA64
References: <C7AB9DA4D0B1F344BF2489FA165E5024040580FE@orsmsx404.jf.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024040580FE@orsmsx404.jf.intel.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 20.02.2004 21:40:40,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 20.02.2004 21:39:45,
	Serialize complete at 20.02.2004 21:39:45
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nguyen, Tom L wrote:

>Friday, Feb. 20, 2004 10:58 AM, Mika Penttilä wrote:
>
>  
>
>>ia64 already has a function ia64_alloc_vector(void) in 
>>arch/ia64/kernel/irq_ia64, why the doubling?
>>    
>>
>
>+#ifndef CONFIG_PCI_USE_VECTOR
> int
> ia64_alloc_vector (void)
> {
>@@ -67,6 +68,7 @@
> 		panic("ia64_alloc_vector: out of interrupt vectors!");
> 	return next_vector++;
> }
>+#endif
>
>#ifndef CONFIG_PCI_USE_VECTOR is added in arch/ia64/kernel/irq_ia64.c
>as above to avoid the double definement of ia64_alloc_vector(void).
>Setting CONFIG_PCI_USE_VECTOR to 'Y' by enabling MSI support will
>use function ia64_alloc_vector(void) defined in drivers/pci/msi.c.
>The main reason behind it is to keep track of the number of vectors
>already assigned during the runtime. Keeping track of already assigned
>vectors is required in MSI implementation.
>
>Thanks,
>Long 
>
>  
>
I see, thanks

--Mika


