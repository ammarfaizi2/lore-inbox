Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbWEaXiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbWEaXiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWEaXiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:38:13 -0400
Received: from dvhart.com ([64.146.134.43]:21906 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965262AbWEaXiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:38:12 -0400
Message-ID: <447E28E3.60804@mbligh.org>
Date: Wed, 31 May 2006 16:38:11 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@google.com, linux-kernel@vger.kernel.org, apw@shadowen.org,
       ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com>	<20060531140652.054e2e45.akpm@osdl.org>	<447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
In-Reply-To: <20060531144310.7aa0e0ff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Martin Bligh <mbligh@google.com> wrote:
>>>
>>>
>>>>The x86_65 panic in LTP has changed a bit. Looks more useful now.
>>>>Possibly just unrelated new stuff. Possibly we got lucky.
>>>
>>>What are you doing to make this happen?
>>
>>runalltests on LTP
>>
> 
> 
> We have to get to the bottom of this - there's a shadow over about 500
> patches and we don't know which.
> 
> iirc I tried to reproduce this a couple of weeks back and failed.
> 
> Are you able to narrow it down to a particular LTP test?  It was mtest01 or
> something like that?  Perhaps we can identify a particular command line
> which triggers the fault in a standalone fashion?

The LTP output is here:

http://test.kernel.org/abat/33803/debug/test.log.1

The last test run was memset01

 From a good test run (http://test.kernel.org/abat/33964/debug/test.log.1)
the one after memset01 is a second instance of the same.

Which is bad I suppose, in that it's likely an intermittent failure.
Perhaps you can try running memset01 in a loop? I don't have such a
box set up here right now, I'm afraid ... will see what I can do.

OTOH, it looks like this might be a different failure than the double
fault we saw in previous -mm's, which was consistently in mtest01, IIRC.

M.
