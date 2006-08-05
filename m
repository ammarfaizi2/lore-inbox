Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWHEE0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWHEE0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 00:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWHEE0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 00:26:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:36589 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422733AbWHEE0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 00:26:24 -0400
Message-ID: <44D41DEF.7040301@vmware.com>
Date: Fri, 04 Aug 2006 21:26:23 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 3/8] Allow a kernel to not be in ring 0.
References: <200608042045_MC3-1-C721-8608@compuserve.com>
In-Reply-To: <200608042045_MC3-1-C721-8608@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <20060803002518.190834642@xensource.com>
>
> On Wed, 02 Aug 2006 17:25:13 -0700, Jeremy Fitzhardinge wrote:
>
>   
>> We allow for the fact that the guest kernel may not run in ring 0.
>> This requires some abstraction in a few places when setting %cs or
>> checking privilege level (user vs kernel).
>>     
>
> I made some changes:
>
> a. Added some comments about the SEGMENT_IS_*_CODE() macros.
> b. Added a USER_RPL macro.  (You were comparing a value to a mask
>    in some places and to the magic number 3 in other places.)
> c. Changed the entry.S tests for LDT stack segment to use the macros.
>   

These changes look great.  Ack-ed.  I had some similar ones before that 
never made it from my tree, as I got carried away and tried to unify the 
user descriptor conversion functions... someday I'll get to it again.

Zach
