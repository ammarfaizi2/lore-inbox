Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUEYEbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUEYEbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUEYEbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:31:42 -0400
Received: from alt.aurema.com ([203.217.18.57]:12185 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S264579AbUEYEbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:31:40 -0400
Message-ID: <40B2CB0E.8030606@aurema.com>
Date: Tue, 25 May 2004 14:26:54 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Peter Williams <peterw@aurema.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       kanderso@redhat.com, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, limin@sgi.com, jlan@sgi.com,
       linux-kernel@vger.kernel.org, jh@sgi.com, Paul Jackson <pj@sgi.com>,
       gh@us.ibm.com, Erik Jacobson <erikj@subway.americas.sgi.com>,
       ralf@suse.de, Vivek Kashyap <kashyapv@us.ibm.com>,
       lse-tech@lists.sourceforge.net, mason@suse.com
Subject: Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com>	<40B2534E.3040302@watson.ibm.com> <40B2A78E.3060302@aurema.com>
In-Reply-To: <40B2A78E.3060302@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
> processes are assigned.   Processors can be moved between CPU pools and 
> when this happens it is necessary to visit all the processes that are 
> assigned to the pools involved (one losing and one gaining the 
> processor) and change their CPU affinity masks to reflect the new 
> assignment of processors.  PAGG would be ideal for implementing this.
> 
> At the same time, a resource management client could be controlling 
> resources allocated to processes based on some other criteria such as 
> the real user or the application being run without regard to which CPU 
> pool they are running in.

Additionally, it seems to me that even within the field of resource 
management it is not necessarily the case that the same grouping is 
required for different resource types e.g. the grouping for control of 
CPU resources might be different to the grouping for control of network 
bandwidth allocation or disk space or disk I/O bandwidth, etc.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


