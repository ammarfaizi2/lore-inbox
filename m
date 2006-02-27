Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWB0JKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWB0JKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWB0JKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:10:47 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:19060 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750867AbWB0JKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:10:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fHt5djqvTLEADFEfCwWPCRUOUmLCw2nPP7VxF6y/ZdgS2AUONLiCvBfR7U6UEtIo4T7covB5BTuT8X43UpaooKOddzKlBeqsSjNJKdOa/zeF6QNu/6SspnOv/VwYkGoKzWs5WwK+h3JuhjIh9WHM1YwductOl9LNcQ+mpPobJ6A=  ;
Message-ID: <4402C217.3070401@yahoo.com.au>
Date: Mon, 27 Feb 2006 20:10:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: nagar@watson.ibm.com
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Patch 0/7] Per-task delay accounting
References: <1141026996.5785.38.camel@elinux04.optonline.net>
In-Reply-To: <1141026996.5785.38.camel@elinux04.optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> The following patches add accounting for the delays seen by tasks in
> a) waiting for a CPU (while being runnable)
> b) completion of synchronous block I/O initiated by the task
> c) swapping in pages (i.e. capacity misses).
> 
> Such delays provide feedback for a task's cpu priority, io priority and
> rss limit values. Long delays, especially relative to other tasks, can
> be a trigger for changing a task's cpu/io priorities and modifying its
> rss usage (either directly through sys_getprlimit() that was proposed
> earlier on lkml or by throttling cpu consumption or process calling
> sys_setrlimit etc.)
> 

Can we get an idea about the actual userspace programs and algorithms
that use this feedback? Links, performance numbers, etc.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
