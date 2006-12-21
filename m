Return-Path: <linux-kernel-owner+w=401wt.eu-S1161066AbWLUAJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWLUAJ1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWLUAJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:09:27 -0500
Received: from smtpout.mac.com ([17.250.248.181]:65277 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161066AbWLUAJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:09:26 -0500
In-Reply-To: <1166561743.3365.1282.camel@laptopd505.fenrus.org>
References: <20061219185223.GA13256@srcf.ucam.org> <1166556889.3365.1269.camel@laptopd505.fenrus.org> <20061219194410.GA14121@srcf.ucam.org> <1166558602.3365.1271.camel@laptopd505.fenrus.org> <20061219200803.GA14332@srcf.ucam.org> <1166559785.3365.1276.camel@laptopd505.fenrus.org> <20061219203251.GA14648@srcf.ucam.org> <1166561743.3365.1282.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1F354B08-BE21-4084-8B97-5CF90BAB4156@mac.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       david-b@pacbell.net, gregkh@suse.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Changes to sysfs PM layer break userspace
Date: Wed, 20 Dec 2006 19:08:30 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 19, 2006, at 15:55:43, Arjan van de Ven wrote:
> On Tue, 2006-12-19 at 20:32 +0000, Matthew Garrett wrote:
>> On Tue, Dec 19, 2006 at 09:23:05PM +0100, Arjan van de Ven wrote:
>>> On Tue, 2006-12-19 at 20:08 +0000, Matthew Garrett wrote:
>>>> I'm not sure. Suspending the chip means you lose things like  
>>>> link beat detection, so it's not something you necessarily want  
>>>> to automatically tie to something like interface status.
>>>
>>> right now the "spec" for Linux network drivers assumes that you  
>>> put the NIC into D3 on down, except for cases where Wake-on-Lan  
>>> is enabled etc.
>>
>> Really? I can't find any drivers that seem to do this. The only  
>> calls to pci_set_power_state seem to be in the suspend, resume,  
>> init and exit routines.
>
> your grep missed tg3.c for example, which has a wrapper around the  
> power state code and goes to D3hot on downing of the interface.  
> (just the first one I looked at as a "reference driver", others  
> probably do the same thing)

I actually kind of like this feature; it makes it possible for  
"ifdown" to virtually "unplug" the cable, such that the remote end  
doesn't have an activated link.  Admittedly it would be slightly more  
useful to have the ifdown and the virtual-unplug be separate events.   
There have been at least a few times where my Linux box is connected  
to a network port I don't control that maintains some independent  
state, and it's handy to be able to reset that state remotely.

Cheers,
Kyle Moffett

