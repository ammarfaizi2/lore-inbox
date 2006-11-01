Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946684AbWKAIB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946684AbWKAIB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946686AbWKAIB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:01:29 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:39781 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946684AbWKAIB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:01:28 -0500
Message-ID: <45485357.6050403@openvz.org>
Date: Wed, 01 Nov 2006 10:57:11 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Pavel Emelianov <xemul@openvz.org>, balbir@in.ibm.com, vatsa@in.ibm.com,
       dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com>	 <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org>	 <454638D2.7050306@in.ibm.com>  <45470DF4.70405@openvz.org> <1162314249.28876.120.camel@localhost.localdomain>
In-Reply-To: <1162314249.28876.120.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2006-10-31 at 11:48 +0300, Pavel Emelianov wrote:
>> If memory is considered to be unreclaimable then actions should be
>> taken at mmap() time, not later! Rejecting mmap() is the only way to
>> limit user in unreclaimable memory consumption.
> 
> I don't think this is necessarily true.  Today, if a kernel exceeds its
> allocation limits (runs out of memory) it gets killed.  Doing the
> limiting at mmap() time instead of fault time will keep a sparse memory
> applications from even being able to run.

If limiting _every_ mapping it will, but when limiting only
"private" mappings - no problems at all. BC code lives for
more than 3 years already and no claims from users on this
question yet.

> Now, failing an mmap() is a wee bit more graceful than a SIGBUS, but it
> certainly introduces its own set of problems.
> 
> -- Dave
> 
> 

