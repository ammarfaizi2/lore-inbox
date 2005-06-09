Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVFIW5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVFIW5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVFIW5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:57:24 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:13329 "EHLO
	MMS2.broadcom.com") by vger.kernel.org with ESMTP id S261470AbVFIW5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:57:17 -0400
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Message-ID: <42A8C93A.1090809@broadcom.com>
Date: Thu, 09 Jun 2005 15:56:58 -0700
From: "Narendra Sankar" <nsankar@broadcom.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
cc: gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] Another PCI fix for 2.6.12-rc6
References: <20050609222033.GA12580@kroah.com>
 <20050609.153254.74562706.davem@davemloft.net>
 <42A8C73C.6060005@broadcom.com>
 <20050609.155100.93023939.davem@davemloft.net>
In-Reply-To: <20050609.155100.93023939.davem@davemloft.net>
X-WSS-ID: 6EB616B71VO7118211-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>From: "Narendra Sankar" <nsankar@broadcom.com>
>Date: Thu, 09 Jun 2005 15:48:28 -0700
>
>  
>
>>So it would still be useful to have this patch in, would it not?
>>    
>>
>
>Absolutely, the patch should go in.
>
>I just want to make sure the descrepency between the two Broadcom
>drivers gets resolved.  TG3 does a MSI correctness check, BNX2
>does not.  And this is what doesn't make any sense.
>
>  
>
Actually looking at the bnx2.c code from jeffG 2.6.13 git tree, it seems 
that it also tests for MSIs being delivered.

So both tg3 and bnx2 test for MSI correctness.

My original comment when submitting the patch, was under the assumption 
that these tests were not being done. However that code has got added to 
both drivers.

Naren

