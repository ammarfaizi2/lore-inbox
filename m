Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWB0Iea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWB0Iea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWB0Iea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:34:30 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:16620 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932304AbWB0Iea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:34:30 -0500
Date: Mon, 27 Feb 2006 03:34:28 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 1/7] timespec diff utility
In-reply-to: <1141028554.2992.53.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Message-id: <4402B994.3000909@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141027367.5785.42.camel@elinux04.optonline.net>
 <1141028554.2992.53.camel@laptopd505.fenrus.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>+/*
>>+ * timespec_diff_ns - Return difference of two timestamps in nanoseconds
>>+ * In the rare case of @end being earlier than @start, return zero
>>+ */
>>+static inline nsec_t timespec_diff_ns(struct timespec *start, struct timespec *end)
>>+{
>>+	nsec_t ret;
>>+
>>+	ret = (nsec_t)(end->tv_sec - start->tv_sec)*NSEC_PER_SEC;
>>+	ret += (nsec_t)(end->tv_nsec - start->tv_nsec);
>>+	if (ret < 0)
>>+ 		return 0;
>>+	return ret;
>>+}
>> #endif /* __KERNEL__ */
>> 
>>    
>>
>
>wouldn't it be more useful to have this return a timespec as well, and
>then it'd be generically useful (and it also probably should then be
>uninlined ;)
>  
>
Return another timespec to store the difference of two input timespecs ? 
Would that be useful ?
Didn't quite get it.

--Shailabh




