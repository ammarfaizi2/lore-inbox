Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUHZRpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUHZRpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269305AbUHZRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:44:26 -0400
Received: from eagle.rtlogic.com ([216.87.68.236]:38063 "EHLO
	eagle.rtlogic.com") by vger.kernel.org with ESMTP id S269308AbUHZRj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:39:57 -0400
Message-ID: <412E2058.60302@rtlogic.com>
Date: Thu, 26 Aug 2004 11:39:36 -0600
From: David Rolenc <drolenc@rtlogic.com>
Reply-To: drolenc@rtlogic.com
Organization: RT Logic!
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior in 
2.6 and just a glance at fadvise.c suggests that POSIX_FADV_NOREUSE is 
not implemented any differently than POSIX_FADV_WILLNEED. Am I missing 
something?  I want to read data from disk with readahead and drop the 
data from the page cache as soon as I am done with it. Do I have to call 
fadvise with POSIX_FADV_DONTNEED after every read?

Thanks,

David Rolenc
RT Logic!
www.rtlogic.com 

