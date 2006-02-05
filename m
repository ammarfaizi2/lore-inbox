Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWBEJJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWBEJJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 04:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWBEJJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 04:09:59 -0500
Received: from smtpout.mac.com ([17.250.248.72]:13013 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751579AbWBEJJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 04:09:58 -0500
In-Reply-To: <20060205004327.78926498.akpm@osdl.org>
References: <1138919238.3621.12.camel@localhost> <1138920185.3621.24.camel@localhost> <20060205004327.78926498.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C815B7F7-75F9-404A-9358-FD6E3E08699A@mac.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC 4/4] firewire: add mem1394
Date: Sun, 5 Feb 2006 04:09:44 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2006, at 03:43, Andrew Morton wrote:
> Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> +config IEEE1394_MEMDEV
>> +	tristate "IEEE1394 memory device support"
>> +	depends on IEEE1394 && EXPERIMENTAL
>> +	help
>> +	  Say Y here if you want support for the ieee1394 memory device.
>> +	  This is useful for debugging systems attached via firewire
>> +	  since it usually allows you to read from and write to their  
>> memory,
>> +	  depending on the controller and machine setup.
>
> 1394 is evil.  Does this mean that if a machine is completely dead- 
> and-crashed, we can still suck all its memory out over 1394 with no  
> cooperation from the dead machine's kernel?  If not, what  
> limitations are there?

I think you snipped too much of the description.  This was after the  
part you quoted:

> It differs from raw access (which allows the same usage) in that it  
> provides devices nodes (usually called /dev/fwmem-<guid>) that can  
> be read and written with any tool, as opposed to specialised tools  
> required for raw1394.

This seems to indicate that this is a _client_ for a IEEE1394 memory  
device, as opposed to a server.  Perhaps the description should be  
clarified, but I don't see any security issues (the kernel does not  
expose its own memory, it accesses the memory that another device is  
exposing).

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


