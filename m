Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVGZFDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVGZFDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVGZFDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:03:24 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5295 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261720AbVGZFDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:03:10 -0400
Date: Mon, 25 Jul 2005 23:03:06 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Kernel cached memory
In-reply-to: <4tdIU-479-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42E5C40A.7000709@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4t5s8-68A-33@gated-at.bofh.it> <4tdIU-479-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Pearson wrote:
> Wouldn't having (practically) all your memory used for cache slow down
> starting a new program? First it would have to free up that space, and then
> put stuff in that space, taking potentially twice as long.

If the cache pages are clean (not been modified since they were read 
from the disk), then evicting that data will not take very long. If the 
program you are just starting is not in the cache, then the time taken 
to load it from disk will dwarf the time needed to evict cached pages. 
And there's also the possibility that the cache contains the data you 
are loading, which definitely will speed things up..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

