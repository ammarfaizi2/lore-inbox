Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWC3UGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWC3UGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWC3UGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:06:14 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:5333 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750796AbWC3UGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:06:14 -0500
In-Reply-To: <20060329015738.5dbbb22d@inspiron>
References: <20060329004122.64e91176@inspiron> <Pine.LNX.4.44.0603281654370.22846-100000@gate.crashing.org> <20060329014851.0f54da89@inspiron> <E135E70C-2F39-4007-B4CC-4D1AEBE2EE74@kernel.crashing.org> <20060329015738.5dbbb22d@inspiron>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <207037DC-B6E0-44A5-84C5-14F77D17E174@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][UPDATE] rtc: Added support for ds1672 control
Date: Thu, 30 Mar 2006 14:06:22 -0600
To: Alessandro Zummo <alessandro.zummo@towertech.it>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 28, 2006, at 5:57 PM, Alessandro Zummo wrote:

> On Tue, 28 Mar 2006 17:52:00 -0600
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>>
>>>  shouldn't this be
>>>  if (err < 0)
>>> 	return err;
>>
>> It could be, but doesn't need to.  ds1672_get_control either returns
>> 0 (success) or non-zero (-EIO) for failure.
>>
>>>> +	/* read control register */
>>>> +	err = ds1672_get_control(client, &control);
>>>> +	if (err) {
>>>> +		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
>>>> +		goto exit_detach;
>>>> +	}
>>>
>>>  ditto.
>>
>> ditto.
>
>  ok. will apply, thanks.

Do you have a queue of patches for 2.6.17 or should I send this to  
Andrew to get into 2.6.17?

- kumar
