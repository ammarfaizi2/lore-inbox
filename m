Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264055AbTJ1Rrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTJ1Rrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:47:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51187 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264055AbTJ1Rru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:47:50 -0500
Message-ID: <3F9EABC1.9070009@mvista.com>
Date: Tue, 28 Oct 2003 10:47:45 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
References: <Pine.LNX.4.44.0310271343170.13116-100000@cherise> <3F9DA5A6.3020008@mvista.com> <20031027233934.GA3408@kroah.com>
In-Reply-To: <20031027233934.GA3408@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Mon, Oct 27, 2003 at 04:09:26PM -0700, Mark Bellon wrote:
>  
>
>>The uSDE was built in response to a set of telco and embedded community 
>>requirements. We found it difficult to express our ideas. Everyone 
>>wanted to see code and documentation. Here is the code and the initial 
>>documentation. This is a starting point...
>>
>>    
>>
>>>If not, are you planning on merging your efforts with udev in the future?
>>>
>>>      
>>>
>>It is to everyone's advantage to converge on an implementation of 
>>enumeration that meets all of the requirements.
>>    
>>
>
>What are your requirements, and why does udev not meet them?  Is there
>some major disagreement between what udev does, and what you want to do?
>If so, what?
>
The requirements were collected from the OSDL CGL requirements 
specification version 1.0 and 1.1 ratified September 2002. They come 
from extensive discussions with the OSDL members as part of the 
definition of these requirements, expounding on them:

* The embracing of all device types with no specialization or limitation.

* The ability to have total control over the handling a device via 
external policy programs. Policy programs are invoked with a formal 
command line and description of the event that caused there invocation.

* The "service container" concept. A device is classified (or recognized 
by a pattern match) and this raises an (queued) event which is caught by 
a configurable "service container". The container is an ordered list of 
handlers that process the device.

* Event queuing and aggregation. Minimizing the number of program 
invocations (fork/exec) is critical in embedded environments - small 
processors.

* Aggressive device enumeration. Multiple concurrent policy execution 
and management.

* Device information persistence is a function of device policies, not 
the enumeration framework.
There are many situation where persistence is not an issue at all or 
only in specific cases (like disks). Why always pay for the memory/disk, 
for persistence, when it is not (always) necessary?

* Transactional protection of multiple configuration files is necessary. 
Multiple configuration files must often be modified in unison and 
insurance is necessary that an accurate and correct set of data is used 
when processing devices.

>udev has been out in the world since April, any reason for not helping
>out with the existing project instead of going off and starting your
>own?  It's not that I mind competing projects, it's just that I don't
>see your reasoning as to why there needs to be two different ones.
>  
>
The two packages take philosophically different approaches and arrive 
with (largely) overlapping and some non-overlapping capabilities - after 
all they are both trying to do "the same thing". The uSDE has strengths 
and weaknesses just as udev or any program does. It is certainly 
possible to discuss changes (and make patches) to udev to incorporate 
the key issues addressed in the uSDE implementation.

The uSDE is an encapsulation of ideas and techniques. It is "complete" 
enough for those ideas to be discussed in a community setting and we can 
see how/what to move things together. Think of it as the projects 
"resting place" from which to confidently discuss techniques and 
implementions.

mark


