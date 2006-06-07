Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWFGLrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWFGLrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 07:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFGLrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 07:47:52 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:5829 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750853AbWFGLrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 07:47:52 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       "Brendan Trotter" <btrotter@gmail.com>
Subject: Re: NMI problems with Dell SMP Xeons 
In-reply-to: Your message of "Wed, 07 Jun 2006 10:01:40 +0200."
             <200606071001.40933.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Jun 2006 21:47:40 +1000
Message-ID: <6799.1149680860@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Wed, 7 Jun 2006 10:01:40 +0200) wrote:
>
>>
>> Two ways:
>>
>> (1) Boot with a kernel with CONFIG_ACPI=n, so the OS only finds 2 cpus
>>     in the MPT instead of the 4 listed by ACPI.
>>
>> (2) The kernel has ACPI=y, but is booted with maxcpus=2.
>>
>> In both cases, send_IPI_allbutself() with IPI 2 or an NMI will result
>> in a hard reset.
>
>Sounds both like a "Don't do that when it hurts" . I know some people
>have religious issues with ACPI, but it's simple a fact that many
>modern boxes don't work correctly in obvious or subtle ways without it. 

Building a kernel without ACPI is silly nowadays.  But even with ACPI,
booting with a restricted maxcpus and sending IPI 2 or NMI as broadcast
will kill these boxes.  maxcpus is a valid option.

