Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSJYXju>; Fri, 25 Oct 2002 19:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJYXjt>; Fri, 25 Oct 2002 19:39:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261689AbSJYXjq>;
	Fri, 25 Oct 2002 19:39:46 -0400
Message-ID: <3DB9D79D.8090305@pobox.com>
Date: Fri, 25 Oct 2002 19:45:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Robert Love <rml@tech9.net>, Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000ECE70AE@fmsmsx103.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:

>No, the notion of "sibling" is not clear. The other day a person pointed out
>"the number of the siblings does not include yourself" when she saw the
>variable smp_num_siblings. So with HT enabled, for a cpu the number of the
>siblings should be 1, instead of 2, from an English language perspective.
>But we want to mean the number H/W threads in a processor package. 
>
>And with multi-core, "sibling" is not clear enough to distiguish "core" in a
>processor package and "thread" in a "core".
>  
>


That's fine.  I can be convinced away from "sibling", I'll leave that up 
to others.  Personally I think I prefer "virtual core" over "sibling" 
and "sub-core".

However, "thread" is the least clear of the proposed choices, and should 
not be used.  Anything-but-thread is my position :)  Thread is used to 
describe processes in Linux, those active in hardware and also those 
sleeping in memory, etc.

    Jeff




