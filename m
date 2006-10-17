Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWJQQWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWJQQWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWJQQWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:22:12 -0400
Received: from rtr.ca ([64.26.128.89]:5646 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751279AbWJQQWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:22:10 -0400
Message-ID: <4535032F.2080807@rtr.ca>
Date: Tue, 17 Oct 2006 12:22:07 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jens Axboe <jens.axboe@oracle.com>, Allen Martin <AMartin@nvidia.com>,
       Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com> <452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk> <452F053B.2000906@shaw.ca> <20061013080434.GE6515@kernel.dk> <45344F4D.6070703@shaw.ca> <45345015.2010601@rtr.ca> <45345B16.4090505@shaw.ca>
In-Reply-To: <45345B16.4090505@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Mark Lord wrote:
>> Robert Hancock wrote:
>>>
>>> +/* ADMA Physical Region Descriptor - one SG segment */
>>> +struct nv_adma_prd {
>>> +    __le64            addr;
>>> +    __le32            len;
>>> +    u8            flags;
>>> +    u8            packet_len;
..
>>> +struct nv_adma_cpb {
>>> +    u8            resp_flags;    //0
>>> +    u8            reserved1;     //1
>>> +    u8            ctl_flags;     //2
>>> +    // len is length of taskfile in 64 bit words
>>> +     u8            len;           //3 +    u8            
>>> tag;           //4
>>> +    u8            next_cpb_idx;  //5
>..
>> Are those CPB / PRD structs endian-safe when using a big-endian CPU?
>>
>> Cheers
> 
> They should be, I believe cpu_to_leXX is used whenever the multi-byte 
> elements are being written. 

I was thinking more about the non wordsized fields,
such as the various u8 bytes that gcc will lay out differently
depending upon endianess.

Cheers

