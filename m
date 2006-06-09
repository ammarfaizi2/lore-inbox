Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWFIPk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWFIPk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWFIPk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:40:57 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:5114 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1030217AbWFIPk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:40:56 -0400
Message-ID: <44899681.6070003@nortel.com>
Date: Fri, 09 Jun 2006 09:40:49 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cacheline alignment and per-cpu data
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2006 15:40:53.0016 (UTC) FILETIME=[17362180:01C68BDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone asked me a question that I couldn't answer, so I thought I'd 
pass it on to here.

Suppose I declare an array of a struct type, where the size of the 
struct is not a multiple of the cacheline size.  Each element in the 
array is used by a different cpu.

If I understand it, this would mean that the last member in the data 
belonging to one cpu shares a cacheline with the first member in the 
data belonging to the next cpu.

Will this cause cacheline pingpong?  If I do this sort of thing do I 
need to ensure that the struct is a multiple of cacheline size (or 
specify cacheline alignement)?

Thanks,

Chris
