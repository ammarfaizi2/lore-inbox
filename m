Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVCSM2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVCSM2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 07:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVCSM2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 07:28:39 -0500
Received: from host-81-191-114-177.bluecom.no ([81.191.114.177]:10625 "EHLO
	lille-hjelper") by vger.kernel.org with ESMTP id S262449AbVCSM2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 07:28:31 -0500
Message-ID: <423C1AEC.1050500@procaptura.com>
Date: Sat, 19 Mar 2005 13:28:28 +0100
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
References: <423A9B65.1020103@procaptura.com> <20050318170709.GD14952@kroah.com>
In-Reply-To: <20050318170709.GD14952@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Mar 18, 2005 at 10:12:05AM +0100, Toralf Lund wrote:
>  
>
>>Am I seeing an issue with the PCI functions here, or is it just that I 
>>fail to spot an obvious mistake in the module itself?
>>    
>>
>
>I think it's a problem in your code.  I built and ran the following
>example module just fine (based on your example, which wasn't the
>smallest or cleanest...), with no oops.  Does this code work for you?
>  
>
I'm not able to test that right now (not on the right system), but did 
you try the exact code I submitted? It would be *very* helpful if 
someone could verify that it leads to a crash, before I go any further.

I also have this feeling that an arbitrary change to the code might make 
the module work without really resolving the problem.

>Oh, and the pci_find* functions are depreciated, do not use them, they
>are going away in the near future.  Please use the pci_get* functions
>instead.
>  
>
I think pci_find* are used because the code is supposed to be compatible 
with Linux 2.4 as well. Or did pci_get* exist there, too?

Like I said, most of the code was actually written by someone else...

- T

