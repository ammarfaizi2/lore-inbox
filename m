Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317863AbSGPPng>; Tue, 16 Jul 2002 11:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSGPPnf>; Tue, 16 Jul 2002 11:43:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62675 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317863AbSGPPnf>;
	Tue, 16 Jul 2002 11:43:35 -0400
Date: Tue, 16 Jul 2002 08:45:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Sandy Harris <pashley@storm.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch[ Simple Topology API
Message-ID: <1860160670.1026809142@[10.10.2.3]>
In-Reply-To: <m1sn2knevw.fsf@frodo.biederman.org>
References: <m1sn2knevw.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> They can also go to no-glue 8-way:
>> 
>>     I/O -- A ------ B ------ E ------ G -- I/O
>>            |        |        |        | 
>>            |        |        |        | 
>>     I/O -- C ------ D ------ F ------ H -- I/O
> 
> 
> I think the 8-way topology is a little more interesting than
> presented.  But if not it does look like you can run into issues.
> The more I look at it there appears to be a strong dynamic balance
> in the architecture between having just enough bandwidth, and low
> enough latency not to become a bottleneck, and having a low hardware
> cost. 

Whilst I don't have a definitive diagram, the "back of a napkin" 
sketches we came up with at an OLS dinner looked like this:

     I/O -- A ------ B ---- E ------ G -- I/O
            |           \/           | 
            |           /\           | 
     I/O -- C ------ D ---- F ------ H -- I/O

(please excuse my poor artistic skills). That reduces the max
hops from 4 to 3 (if I haven't screwed something up).

M.

