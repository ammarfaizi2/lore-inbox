Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSIFPew>; Fri, 6 Sep 2002 11:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318756AbSIFPew>; Fri, 6 Sep 2002 11:34:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:56459 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318752AbSIFPeu>;
	Fri, 6 Sep 2002 11:34:50 -0400
Message-ID: <3D78CBF6.10609@us.ibm.com>
Date: Fri, 06 Sep 2002 08:38:30 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <20020905.235159.128049953.davem@redhat.com> <46202575.1031297360@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>Stupid question, are you sure you have CONFIG_E1000_NAPI enabled?
>>
>>NAPI is also not the panacea to all problems in the world.
> 
> No, but I didn't expect throughput to drop by 40% or so either,
> which is (very roughly) what happened. Interrupts are a pain to
> manage and do affinity with, so NAPI should (at least in theory)
> be better for this kind of setup ... I think.

No, no.  Bad Martin!  Throughput didn't drop, "Specweb compliance" dropped. 
  Those are two very, very different things.  I've found that the server 
can produce a lot more throughput, although it doesn't have the 
characteristics that Specweb considers compliant.  Just have Troy enable 
mod-status and look at the throughput that Apache tells you that it is 
giving during a run.  _That_ is real throughput, not number of compliant 
connections.

_And_ NAPI is for receive only, right?  Also, my compliance drop occurs 
with the NAPI checkbox disabled.  There is something else in the new driver 
that causes our problems.

-- 
Dave Hansen
haveblue@us.ibm.com

