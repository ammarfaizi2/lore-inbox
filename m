Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWF2ASF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWF2ASF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWF2ASE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:18:04 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60099 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751836AbWF2ASD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:18:03 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=jQfqMrp82fA/TEfhUvFthBN2ajWHrbLTZyeHvHO7OKmMg1PVFzAaooF5J6+sJr6vj
	ZePMddIgLWV+U9e4IqeJw==
Message-ID: <44A31BFE.3000504@google.com>
Date: Wed, 28 Jun 2006 17:17:02 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org, jeremy@goop.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org,
       linuxppc64-dev@ozlabs.org, drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org>	<20060628034748.018eecac.akpm@osdl.org>	<44A29582.7050403@google.com> <20060628121102.638f08d9.akpm@osdl.org> <44A2DA40.40502@google.com>
In-Reply-To: <44A2DA40.40502@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
>>> How the hell did you figure that one out?
>>
>>
>> Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
>> tight loop.  With that happening, a little two-way wasn't able to make
>> it through `dbench 4' without soiling the upholstery.  Then 
>> bisection-searching.
> 
> 
> Aha. we probably trigger it because the automated test harness dumps a
> bunch of crap out of /proc before and after running dbench then ;-)

OK, your patch does seem to fix it for the automated tests. Not 100%
reliable, since it was a little intermittent before, but it looks
good.

Thanks to both Andrew and Andy.

M.
