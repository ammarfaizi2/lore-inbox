Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWJTQfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWJTQfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWJTQfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:35:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:32582 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932276AbWJTQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:35:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZLbG5yfiB6DAHXjgwm3ynZtMI1uQ6T7FSGg+p0jSqdeamKUV3+jRQwpzzIGVmDjgc5vde43HuNtvfkRlQsG3Azq7tSq3gAjjuBe2MZA/uZRodlk2tluc1jVzbv3Ly1vOLYhC27ifjLLg7B1lXog+qxBzkhT5zS+m6JvM9/lxWwc=
Message-ID: <4538FAC8.4040709@gmail.com>
Date: Sat, 21 Oct 2006 01:35:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: Re: [patch] libata: use correct map_db values for ICH8
References: <20061019132739.10e504ef.kristen.c.accardi@intel.com>	<453891AD.70704@gmail.com> <20061020092622.f564da61.kristen.c.accardi@intel.com>
In-Reply-To: <20061020092622.f564da61.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
>> Do you guys have doc update related to this?  The doc and spec update 
>> still indicate that MAP value is reserved to 00b.  Anyways, if you say 
>> that's right...
>>
>> Acked-by: Tejun Heo <htejun@gmail.com>
>>
> As far as I know, this has always been documented.
> The datasheet is located here:
> http://developer.intel.com/design/chipsets/datashts/313056.htm

Yeap, that's what I've been looking at for the whole time.

> Indicates that 10b is valid for combined mode.  Make sure you are looking
> at device 31 function 2 - for 31 function 5 it is hardwired to 00b, but
> for function 2, it can be 00 or 10.  This was not very clear, so it's
> easy to understand how this could have been misunderstood.  See 
> section 11.1.33 in the notes, or do a search on "combined mode" through
> the doc, and you'll see that MV can be 10b when SCC is 01 on device 31
> function 2.

Ah... you're right.  Thanks for pointing out.

-- 
tejun
