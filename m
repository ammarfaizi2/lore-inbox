Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVB1TGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVB1TGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVB1TD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:03:59 -0500
Received: from www.rapidforum.com ([80.237.244.2]:44504 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261712AbVB1S46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:56:58 -0500
Message-ID: <4223696C.8060407@rapidforum.com>
Date: Mon, 28 Feb 2005 19:56:44 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
References: <4221FB13.6090908@rapidforum.com> <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com> <422239A8.1090503@rapidforum.com> <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com> <42225B34.7020104@rapidforum.com> <Pine.LNX.4.61.0502271905270.19979@chimarrao.boston.redhat.com> <42226607.6020803@rapidforum.com> <4222A887.80301@yahoo.com.au>
In-Reply-To: <4222A887.80301@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This issue has been tracked down more. This bug does NOT appear if I disable preemtive kernel.
Maybe this helps.

Nick Piggin wrote:
> Christian Schmid wrote:
> 
>> I already tried with 300 KB and even used a perl-hash as a 
>> horrible-slow buffer for a readahead-replacement. It still slowed down 
>> on the syswrite to the socket. Thats the strange thing.
>>
> 
> Do you have to use manual readahead though? What is the performance
> like if you just let the kernel do its own thing? The kernel's
> readahead provides things like automatic scaling and thrashing
> control, so if possible you should just stick to that.
> 
> Although you may want to experiment with the maximum readahead on your
> working disks:
> /sys/block/???/queue/read_ahead_kb
> 
> Also, can we get a testcase (ie. minimal compilable code) to reproduce
> this problem?
> 
> Thanks,
> Nick
> 
> 
> 
