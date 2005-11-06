Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVKFIJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVKFIJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKFIJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:09:38 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:14677 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751235AbVKFIJi (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:09:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=QemzeTe/6So4ys0nEdKaolY0/JVR6YQEG44JtzgNMU6uknQ2R6io+qJ201N8Uq7CGgetlDSvZAHgosOlz7PJvR/qIbACbKbGADbEz/ADXZL6PdzaBPSRmWvDOlsbVHMOao052x01RJrvUwb/LDg43c/g+G169TthmFLCUa5RsaQ=  ;
Message-ID: <436DBAC3.7090902@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:11:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [rfc][patch 0/14] mm: performance improvements
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset is a set of performance optimisations
for the mm subsystem. They mainly focus on the page allocator
because that is a very hot path for kbuild, which is my target
workload.

Performance improvements are not finely documented yet, so they
are not indented for merging yet. Also some rmap optimisations
that Hugh probably won't have time to ACK for a while.

However, a slightly older patchset was able to decrease kernel
residency by about 5% for UP, and 7.5% for SMP on a dual Xeon
doing kbuild.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
