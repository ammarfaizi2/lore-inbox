Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVFJK2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVFJK2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVFJK2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:28:11 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8942 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262544AbVFJK1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:27:50 -0400
Message-ID: <42A96BF2.7070203@jp.fujitsu.com>
Date: Fri, 10 Jun 2005 19:31:14 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 03/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com> <42A83B6D.8010703@jp.fujitsu.com> <20050609165719.GC9597@kroah.com>
In-Reply-To: <20050609165719.GC9597@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>> /* definition of ia64 iocookie */
>>-typedef unsigned long iocookie;
>>+struct __iocookie {
>>+	struct list_head	list;
>>+	struct pci_dev		*dev;	/* targeting device */
>>+	unsigned long		error;	/* error flag */
>>+};
>>+typedef struct __iocookie iocookie;
> 
> Hm, why not just make the thing be a "struct iocookie" in the first
> place, then we don't have to mess with a typedef at all.  And then each
> arch can define how the structure will look like in their private .c
> files, ensuring that no user can ever try to touch the structure
> themselves.

Aha.., maybe I understand it just now.
I don't know why, but I just stuck to typedef...

Thanks,
H.Seto

