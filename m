Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUEDSOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUEDSOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbUEDSOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:14:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:50360 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264551AbUEDSOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:14:14 -0400
Message-ID: <4097DD64.5080708@watson.ibm.com>
Date: Tue, 04 May 2004 14:13:56 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
References: <4090BBF1.6080801@watson.ibm.com> <20040430174117.A13372@infradead.org> <20040504172941.GD11346@logos.cnet>
In-Reply-To: <20040504172941.GD11346@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Fri, Apr 30, 2004 at 05:41:18PM +0100, Christoph Hellwig wrote:
>  
>
>>>The basic concepts and motivation of CKRM remain the same as described
>>>in the overview at http://ckrm.sf.net. Privileged users can define
>>>classes consisting of groups of kernel objects (currently tasks and
>>>sockets) and specify shares for these classes. Resource controllers,
>>>which are independent of each other, can regulate and monitor the
>>>resources consumed by classes e.g the CPU controller will control the
>>>CPU time received by a class etc. Optional classification engines,
>>>implemented as kernel modules, can assist in the automatic
>>>classification of the kernel objects (tasks/sockets currently) into
>>>classes.
>>>      
>>>
>>I'd still love to see practical problems this thing is solving.  It's
>>a few thousand lines of code, not written to linux style guidelines,
>>sometimes particularly obsfucated with callbacks all over the place.
>>
>>I'd hate to see this in the kernel unless there's a very strong need
>>for it and no way to solve it at a nicer layer of abstraction, e.g.
>>userland virtual machines ala uml/umlinux.
>>    
>>
>
>I have been reading CKRM docs this week and I think something which provides the 
>same functionality is required for v2.7.
>
>I haven't read the code yet, though. It probably should be converted to 
>"linux style" and simplified whenever possible.
>
>Right now our resource-limit infrastructure is very basic and limited. CKRM 
>provides advanced/fine grained resource management.
>
>  
>
Marcelo, that was the intention, namely resource management within a 
single OS image for
a variety of workload.  The unit of resource management is a flexible 
resource classes.
At the current time we have mainly focused on the infrastructure and 
have not spent the
cycles to forward port our previous schedulers.
Those schedulers were mainly meant to be a starting discussion point to 
start thinking how
these schedulers are to be written in a matter that they are acceptable 
to the mainline, i.e.
no or minimal additional overhead, preserving existing heuristics, etc. etc.

As for your subsequent message on the classification engine.
The classification engine is optional. If configured it is also called 
along
various kernel events, such as fork, exec, exit ... Rather than throwing 
this into userspace,
we compromised on putting this into a loadable module.

The new RCFS (Resource Control FileSystem) brings a generic, expandable 
interface to the table.
Let us know what other questions you have ....

-- Hubertus





