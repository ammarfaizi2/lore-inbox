Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVDYQEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVDYQEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVDYQD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:03:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:53432 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262635AbVDYQAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:00:41 -0400
Message-ID: <426D1402.5050509@austin.ibm.com>
Date: Mon, 25 Apr 2005 11:00:02 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
CC: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Hotplug CPU and setaffinity?
References: <20050423173514.GA7111@gallifrey> <20050423182227.GE18688@otto> <20050424123501.GB7111@gallifrey>
In-Reply-To: <20050424123501.GB7111@gallifrey>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>The affinity of the process is reset to the default and it is migrated
>>to another cpu, for better or worse.  The kernel assumes the admin
>>know what he/she is doing.
> 
> 
> Yeh that's ok - is there anything that would hotplug a cpu
> automatically; say on receiving some MCEs ; and thus not
> give the admin a look in.

On ppc64 we have CPU guard, which would remove a processor if it is 
failing.  Of course, the implications of not removing such a CPU are 
pretty terrible.

> 
> 
>>>In particular I was thinking of the cases where a thread has a
>>> functional reason for remaining on one particular CPU (e.g. if you
>>>had calibrated for some feature of that CPU say its time stamp
>>>counter skew/speed). Another case would be a set of threads which
>>>had set their affinity to the same CPU and then made memory
>>>consistency or locking assumptions that wouldn't be valid
>>>if they got rescheduled onto different CPUs.

This sounds like a theoretical problem.  Can you think of any real 
examples?  The only cases I can think of cause performance hits, but not 
functional problems.


