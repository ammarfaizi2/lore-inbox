Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVHYJTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVHYJTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVHYJTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:19:31 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:22253 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S964897AbVHYJTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:19:31 -0400
Message-ID: <430D8CA3.3030709@cosmosbay.com>
Date: Thu, 25 Aug 2005 11:17:23 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain> <1124956563.3222.8.camel@laptopd505.fenrus.org> <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org>
In-Reply-To: <20050825090854.GA9740@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 25 Aug 2005 11:17:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig a écrit :
> On Thu, Aug 25, 2005 at 10:45:12AM +0200, Eric Dumazet wrote:
> 
>>This patch assumes that atomic_read() is a plain {return v->counter;} on 
>>all architectures. (keywords : sysctl, /proc/sys/fs/file-nr, proc_dointvec)
> 
> 
> But that's not true.  You need to write you own sysctl handler for it,
> probably worth adding a generic atomic_t sysctl handler while you're
> at it.
> 

I checked linux-2.6.13-rc7 tree, and atomic_read() is just a wrapper to read 
v->counter.

In the ancient times, yes, atomic_read() was different on some archs, but not 
today.

Eric

