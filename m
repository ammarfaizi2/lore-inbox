Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbSJADlj>; Mon, 30 Sep 2002 23:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbSJADlj>; Mon, 30 Sep 2002 23:41:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28616 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261469AbSJADli>;
	Mon, 30 Sep 2002 23:41:38 -0400
Message-Id: <200210010346.g913ktfP148022@northrelay01.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Maneesh Soni" <maneesh@in.ibm.com>
To: "Andrew Morton" <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Martin.J.Bligh" <mbligh@aracnet.com"@northrelay01.pok.ibm.com
Subject: Re: 2.5.39-mm1
Date: Tue, 01 Oct 2002 09:28:44 +0530
References: <3D9804E1.76C9D4AE@digeo.com> <3D9896F6.8E584DC5@digeo.com>
Reply-To: maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002 23:55:50 +0530, Andrew Morton wrote:

> "Martin J. Bligh" wrote:
>> 
>> Which looks about the same to me? Me slightly confused.
> 
> I expect that with the node-local allocations you're not getting a lot
> of benefit from the lock amortisation.  Anton will.
> 
> It's the lack of improvement of cache-niceness which is irksome. Perhaps
> the heuristic should be based on recency-of-allocation and not
> recency-of-freeing.  I'll play with that.
> 
>> Will try
>> adding the original hot/cold stuff onto 39-mm1 if you like?
> 
> Well, it's all in the noise floor, isn't it?  Better off trying broader
> tests.  I had a play with netperf and the chatroom benchmark.  But the
> latter varied from 80,000 msgs/sec up to 350,000 between runs. --

Hello Andrew,

chatroom benchmark gives more consistent results with some delay 
(sleep 60) between two runs.

Maneesh
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
