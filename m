Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWBVWAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWBVWAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWBVWAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:00:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:26346 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750883AbWBVWAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:00:13 -0500
Message-ID: <43FCDEE4.1070500@zytor.com>
Date: Wed, 22 Feb 2006 14:00:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com> <20060222.135430.44726149.davem@davemloft.net>
In-Reply-To: <20060222.135430.44726149.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Please double check that we report the correct page size to userspace
> and not a fixed 4K value :-)

I haven't found any platforms yet which don't use the AT_PAGESZ entry in 
the ELF area correctly.  This is obviously a Good Thing.  The klibc 
"getpagesize" test tests this explicitly.

	-hpa
