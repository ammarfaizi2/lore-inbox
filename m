Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbVIIBew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbVIIBew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVIIBew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:34:52 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:3057 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S965227AbVIIBew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:34:52 -0400
In-Reply-To: <1126223767.29803.34.camel@gaston>
References: <1126223767.29803.34.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A32A4DA9-99D6-4574-AD5D-F1C0DFC8AE75@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       "Paul Mackerras" <paulus@samba.org>, <linuxppc-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc: Merge tlb.h
Date: Thu, 8 Sep 2005 20:34:52 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 8, 2005, at 6:56 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2005-09-08 at 16:11 -0500, Kumar Gala wrote:
>
>> Merged tlb.h between asm-ppc32 and asm-ppc64 into asm-powerpc.  Also,
>>
> fixed
>
>> a compiler warning in arch/ppc/mm/tlb.c since it was roughly related.
>>
>> Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>
>>
>
> Do we want to do that ?
>
> Replacing 2 different files with one split in #ifdef isn't a  
> progress...
> As I said, I think we need two subdirs for the low level stuffs  
> that is
> different, and that includes at this point all of the memory  
> management
> related stuff.

I understand, but I'm also not sure if its progress to duplicate a  
major of a file that is common.

In this case it might be better handled by having specific versions  
per "sub-arch".  I think the key is determining which files should be  
handled via sub-arch diffs and which should be handled via ifdef's in  
the file.

Some cases like ppc_asm are so similar that it seems better to have a  
single file and ifdef the specific case.

> In addition, I'd appreciate if we could avoid touching ppc64 mm  
> related
> files completely for a couple of weeks as I'm working on a fairly big
> patch that I'm really tired of having to rebase all the time ;)

Will avoid touch any other mm related headers than :)

- kumar
