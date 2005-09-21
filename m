Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVIUQ0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVIUQ0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVIUQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:26:44 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:2250 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751113AbVIUQ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:26:44 -0400
Message-ID: <433189B5.3030308@nortel.com>
Date: Wed, 21 Sep 2005 10:26:29 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: dentry_cache using up all my zone normal memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 16:26:33.0974 (UTC) FILETIME=[3B226160:01C5BEC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.6.10 on a pentium-M system with 3 gig of RAM.  I'm running 
with NFS root, no swap.

Normally at idle I use about 20MB of memory.

When I run LTP everything is fine until it hits the rename14 test. 
Invariably during that test the OOM killer kicks in.

With a bit of digging the culprit appears to be the dentry_cache.  The 
last log I have shows it using 817MB of memory.  Right after that the 
oom killer kicked me off the system.  When I logged back in, the cache 
usage was back down to normal and everything was fine.

Anyone have any suggestions?

Chris
