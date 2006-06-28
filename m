Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423370AbWF1PHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423370AbWF1PHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423367AbWF1PHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:07:51 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:48389 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1422635AbWF1PHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:07:50 -0400
Message-ID: <44A29AF5.4010501@shadowen.org>
Date: Wed, 28 Jun 2006 16:06:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org, jeremy@goop.org,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org> <20060628034748.018eecac.akpm@osdl.org> <44A29582.7050403@google.com>
In-Reply-To: <44A29582.7050403@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Andrew Morton wrote:
> 
>> On Wed, 28 Jun 2006 03:42:15 -0700
>> Andrew Morton <akpm@osdl.org> wrote:
>>
>>
>>> his is caused by the vsprintf() changes.  Right now, if you do
>>>
>>>     snprintf(buf, 4, "1111111111111");
>>>
>>> the memory at `buf' gets [31 31 31 31 00], which is not good.
>>>
>>> This'll plug it, but I didn't check very hard whether it still has any
>>> off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's
>>> OK..
> 
> 
> Aha, you're a genius! How the hell did you figure that one out?
> 
> Andy / Steve ... any chance one of you could kick this through the
> harness? Against -git10 or so, I'd think
> 
> Thanks,


Suitibly kicked ... against 2.6.17-git10.

-apw

