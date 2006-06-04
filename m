Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWFDAtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWFDAtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 20:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWFDAtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 20:49:04 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64460 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750990AbWFDAtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 20:49:03 -0400
Message-ID: <44822DF4.5090504@zytor.com>
Date: Sat, 03 Jun 2006 17:48:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
References: <6ined-4gY-17@gated-at.bofh.it> <6ined-4gY-21@gated-at.bofh.it> <6inee-4gY-23@gated-at.bofh.it> <6ined-4gY-15@gated-at.bofh.it> <6inxv-4U2-17@gated-at.bofh.it> <448220CE.4030709@shaw.ca>
In-Reply-To: <448220CE.4030709@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> H. Peter Anvin wrote:
>> For something that generates I/O transactions, it's imperative to
>> generate the smallest possible number of transactions.  Furthermore,
>> smaller than dword transactions aren't burstable, except at the
>> beginning and end of a burst.
> 
> Well, theoretically for writes they could be, if the memory region was 
> prefetchable and the PCI chipset supported byte merge. It certainly 
> isn't optimal however.
> 

If so, then merging doesn't matter either way.

	-hpa
