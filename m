Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWFAUYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWFAUYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWFAUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:24:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:37290 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030275AbWFAUYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:24:05 -0400
Message-ID: <447F4CDB.2060000@zytor.com>
Date: Thu, 01 Jun 2006 13:23:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>, hpa@zytor.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] klibc
References: <20060601194751.GD17809@localhost> <20060601140607.A1688@openss7.org>
In-Reply-To: <20060601140607.A1688@openss7.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian F. G. Bidulock wrote:
> On Thu, 01 Jun 2006, Bob Picco wrote:
>>  
>> -#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
>> +#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__) && \
>> +	!defined(__powerpc64__)
> 
> Why not just !defined(__LP64__) ?

_BITSIZE == 64 is really the right formula... if I remember correctly, there were some 
64-bit platforms (Alpha?) which didn't conform, though.  I will look at this later today.

	-hpa

