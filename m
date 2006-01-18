Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWARP2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWARP2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWARP2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:28:41 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:52097
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030345AbWARP2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:28:41 -0500
Message-ID: <43CE5E9D.3090707@microgate.com>
Date: Wed, 18 Jan 2006 09:28:29 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <xslaby@fi.muni.cz>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] synclink_gt fix size of register value storage
References: <20060118120337.9AB3522B3C4@anxur.fi.muni.cz>
In-Reply-To: <20060118120337.9AB3522B3C4@anxur.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>>-	unsigned char val;
>>+	unsigned short val;
> 
> Shouldn't be this u16 rather than ushort?

It could be argued that way.
A quick search of CodingStyle does not
reference the uXX types.

unsigned short is guaranteed to be
at least 16 bits, so no data is lost.
The value is written to the register using
writew(), so no more than 16 bits are used.
Using unsigned short here will always work.

Do you know of a Linux environment where
unsigned short is not 16 bits?

-- 
Paul Fulghum
Microgate Systems, Ltd.
