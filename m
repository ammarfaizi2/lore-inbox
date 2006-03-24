Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWCXPYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWCXPYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWCXPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:24:46 -0500
Received: from fmr19.intel.com ([134.134.136.18]:7352 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750719AbWCXPYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:24:45 -0500
Message-ID: <44240F30.10801@linux.intel.com>
Date: Fri, 24 Mar 2006 16:24:32 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ashok Raj <ashok.raj@intel.com>
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820
 table
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <200603231856.12227.ak@suse.de> <1143140539.3147.44.camel@laptopd505.fenrus.org> <1143141320.3147.47.camel@laptopd505.fenrus.org> <20060324072250.A13756@unix-os.sc.intel.com>
In-Reply-To: <20060324072250.A13756@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Thu, Mar 23, 2006 at 11:15:19AM -0800, Arjan van de Ven wrote:
>>    >
>>    > I'll do a new patch using this for x86_64 though, no need to make a
>>    > second function like this.
>>
>>     int  __init  e820_mapped(unsigned  long  start,  unsigned  long  end,
>>    unsigned type)
> 
> 
> Why not use the same type of function like x86_64 as well instead of the newly
> added is_820_mapped()? If the purpose of both functions is the same, i386 could benefit 
> with same style code instead of a slight variant.

the purpose is not the same. the e820_mapped function is far less strict in its check
(I'm still afraid it is too weak for this purpose actually)

and it's not is_e820_mapped but is_e820_reserved()


