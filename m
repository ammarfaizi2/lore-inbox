Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUE0GCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUE0GCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 02:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUE0GCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 02:02:44 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:49274 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261606AbUE0GCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 02:02:41 -0400
Message-ID: <40B5847E.90604@yahoo.com.au>
Date: Thu, 27 May 2004 16:02:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Felker <tcfelker@mtco.com>
CC: Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B47D4C.6050206@yahoo.com.au> <20040526123740.GA14584@citd.de> <200405270014.10096.tcfelker@mtco.com>
In-Reply-To: <200405270014.10096.tcfelker@mtco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Felker wrote:
> On Wednesday 26 May 2004 7:37 am, Matthias Schniedermeyer wrote:
> 
> 
>>program to kernel: "i read ONCE though this file caching not useful".
> 
> 
> Very true.  The system is based on the assumption that just-used pages are 
> more useful that older pages, and it slows when this isn't true.  We need 
> ways to tell the kernel whether the assumption holds.
> 

A streaming flag is great, but we usually do OK without it. There
is a "used once" heuristic that often gets it right as far as I
know. Basically, new pages that are only used once put almost zero
pressure on the rest of the memory.

It has a few corner cases where it breaks down. Hopefully they can
be improved...
