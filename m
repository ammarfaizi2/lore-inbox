Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWCVXc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWCVXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWCVXc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:32:57 -0500
Received: from smtpout.mac.com ([17.250.248.45]:51963 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932436AbWCVXc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:32:56 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
In-Reply-To: <20060322.141300.62168729.davem@davemloft.net>
References: <BE2452EA-2566-4C2A-B07D-BD63404A42C1@mac.com> <20060322.141300.62168729.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE85F1AA-A258-4D4F-A46F-34253AEE280E@mac.com>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: 2.6.16 hugetlbfs problem
Date: Wed, 22 Mar 2006 17:32:57 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 22, 2006, at 4:13 PM, David S. Miller wrote:

> From: Mark Rustad <mrustad@mac.com>
> Date: Wed, 22 Mar 2006 16:10:33 -0600
>
>> I seem to be having trouble using hugetlbfs with kernel 2.6.16. I
>> have a small test program that worked with 2.6.16-rc5, but fails with
>> 2.6.16-rc6 or the release. The program is below. Given a path to a
>> file on a hugetlbfs, it opens/creates the file, mmaps it and tries to
>> access the first word. On 2.6.16-rc5, it works. On 2.6.16, it hangs
>> page-faulting until it is killed.
>
> On what platform?  Things like hugetlb and address space layout
> (you're requesting a specific mmap() address I noticed) are very
> platform specific.

This is on a Xeon, without PAE with the 1GB no-highmem memory map, in  
all three cases. This is a 32-bit kernel running on a Nacona CPU. I  
also had an unmap call over the range to be mmap-ed, but the failure/ 
success cases were the same, so I removed it to reduce the test  
program further.

-- 
Mark Rustad, MRustad@mac.com

