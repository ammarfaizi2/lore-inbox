Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUEYPOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUEYPOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUEYPOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:14:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7908 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264860AbUEYPOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:14:50 -0400
Message-ID: <40B36288.9050205@watson.ibm.com>
Date: Tue, 25 May 2004 11:13:12 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Rik van Riel <riel@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       kanderso@redhat.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       limin@sgi.com, jlan@sgi.com, linux-kernel@vger.kernel.org, jh@sgi.com,
       Paul Jackson <pj@sgi.com>, gh@us.ibm.com,
       Erik Jacobson <erikj@subway.americas.sgi.com>, ralf@suse.de,
       lse-tech@lists.sourceforge.net, Vivek Kashyap <kashyapv@us.ibm.com>,
       mason@suse.com
Subject: Re: [Lse-tech] Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com> <40B2534E.3040302@watson.ibm.com> <40B2A78E.3060302@aurema.com>
In-Reply-To: <40B2A78E.3060302@aurema.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> Hubertus Franke wrote:
>
>>
>> One important input the PAGG team could give is some real
>> examples where actually multiple associations to different groups
>> is required and help us appreciate that position and let us
>> see how this would/could be done in CKRM.
>
>
> One example would be the implementation of CPU sets (or pools) a la 
> Solaris where there are named CPU pools to which processors and 
> processes are assigned.   Processors can be moved between CPU pools 
> and when this happens it is necessary to visit all the processes that 
> are assigned to the pools involved (one losing and one gaining the 
> processor) and change their CPU affinity masks to reflect the new 
> assignment of processors.  PAGG would be ideal for implementing this.
>
> At the same time, a resource management client could be controlling 
> resources allocated to processes based on some other criteria such as 
> the real user or the application being run without regard to which CPU 
> pool they are running in.
>
> Peter

Good one, at question though is again though is whether the very 
communalities warrant some realignment. We want to hook into the base 
schedulers and be the clearing house or umbrella to consolidate all the 
ideas, such as the well defined RCFS recently introduced together with 
Rik van Riel. PAGG is as stated a way of doing things outside the core 
kernel and hookable schedulers have been several times rejected at the 
lkml base.

One potential is to agree that the communalities are so few that it 
makes sense to continue with both approaches independently.

-- Hubertus

