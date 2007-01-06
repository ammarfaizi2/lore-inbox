Return-Path: <linux-kernel-owner+w=401wt.eu-S932183AbXAFUhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbXAFUhP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXAFUhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:37:15 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:51319 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbXAFUhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:37:14 -0500
Message-ID: <45A00878.1000705@vmware.com>
Date: Sat, 06 Jan 2007 12:37:12 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org,
       jeremy@xensource.com, rusty@rustcorp.com.au
Subject: Re: + paravirt-vmi-timer-patches.patch added to -mm tree
References: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net> <1168106760.26086.222.camel@imap.mvista.com>
In-Reply-To: <1168106760.26086.222.camel@imap.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Fri, 2006-12-15 at 14:27 -0800, akpm@osdl.org wrote:
>   
>> +
>> +config NO_IDLE_HZ
>> +       bool
>> +       depends on PARAVIRT
>> +       default y
>> +       help
>> +         Switches the regular HZ timer off when the system is going
>> idle.
>> +         This helps a hypervisor detect that the Linux system is
>> idle,
>> +         reducing the overhead of idle systems. 
>>     
>
>
> There is already a dynamic tick (NO_HZ) system in the -mm tree .. Given
> that this implementation seems unnecessary. Why do you need another
> different system to do this?
>   

We don't.  This was written before the dynamic tick code, and now they 
need to be merged.  Until then, they can safely coexist.

Zach

