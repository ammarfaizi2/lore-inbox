Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUCDVGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUCDVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:06:31 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1528 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262138AbUCDVG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:06:29 -0500
Message-ID: <40479A50.9090605@nortelnetworks.com>
Date: Thu, 04 Mar 2004 16:06:24 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: problem with cache flush routine for G5?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're running into issues with the "flush_data_cache" routine on the G5.

For the G5, the L1 dcache is 32K and the L2 cache is 512K. At 128 
bytes/cacheline, that's 256 and 4096 cachelines, respectively.

In the existing tree, NUM_CACHE_LINES is set to 128*8, or 1024.  Is this 
an oversight or am I missing something?

Also, I'm curious why the dcbf instruction is not used for this.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

