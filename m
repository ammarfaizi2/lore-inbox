Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWDHO2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWDHO2X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 10:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDHO2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 10:28:23 -0400
Received: from dvhart.com ([64.146.134.43]:63176 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750952AbWDHO2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 10:28:22 -0400
Message-ID: <4437C883.20207@mbligh.org>
Date: Sat, 08 Apr 2006 07:28:19 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: wierd failures from -mm1
References: <4436AA05.7020203@mbligh.org>	<1144433309.24221.7.camel@localhost.localdomain>	<4436AD7D.5070307@mbligh.org> <20060407121122.61d7f979.akpm@osdl.org>
In-Reply-To: <20060407121122.61d7f979.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Bligh <mbligh@mbligh.org> wrote:
> 
>>Dave Hansen wrote:
>> > On Fri, 2006-04-07 at 11:05 -0700, Martin Bligh wrote:
>> > 
>> >>http://test.kernel.org/abat/27596/debug/console.log
>> >>Hangs after bringing up cpus. 
>> > 
>> > 
>> > See attached patch.  It fixes curly.
>>
>> Splendid -thanks. This may well fix the first two ... I think the reiser
>> thing is likely still borked though.
> 
> 
> The reiserfsck problem looks like a failed mlockall.  Reverting
> mm-posix-memory-lock.patch should fix it.

Didn't manage to get that test kicked off before you released -mm2,
which seems to work fine (across the boxes that still work, at least)

M.
