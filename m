Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVKPNnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVKPNnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVKPNnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:43:53 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:12720 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030314AbVKPNnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:43:52 -0500
Message-ID: <437B3749.5090800@t-online.de>
Date: Wed, 16 Nov 2005 14:42:33 +0100
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, luke.adi@gmail.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>	<20051101165136.GU8009@stusta.de>	<489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>	<489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>	<20051104230644.GA20625@kroah.com>	<489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>	<20051107165928.GA15586@kroah.com> <20051107235035.2bdb00e1.akpm@osdl.org>
In-Reply-To: <20051107235035.2bdb00e1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XjauYkZH8eImMwnzuwWwb7wWhgmAwWcw+4t8lqt07E3pkM85CRWyrf
X-TOI-MSGID: 20ca5cd6-276f-4f7c-9291-67140926f84d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>+asmlinkage int sys_bfin_spinlock(int *spinlock)
> 
> 
> Whoa, that's a syscall I never expected to see.  What's it do?

Replaces the TESTSET instruction, which has a few errata that make it 
unreliable.  It's used by the pthreads library to provide atomic operations.

> Shouldn't
> it be using get_user() and put_user()?  Or will this forever be a nommu
> arch?

We currently don't expect that this code will ever support a MMU, but I 
suppose it could use get/put_user for clarity.


Bernd
