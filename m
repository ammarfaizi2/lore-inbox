Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265327AbUEZH1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUEZH1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUEZH1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:27:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64142 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265327AbUEZH12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:27:28 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 00:31:16 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40B43B5F.8070208@nodivisions.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRC7EFjnCM+Y9BNS4SdC0T85K5ooQABZFSQ
Message-Id: <S265327AbUEZH12/20040526072728Z+1185@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a really good point. I think the bar should be set at max
performance for systems that never need to use the swap device. 

If someone wants to tune swap performance to their hearts content, so be it.
But given cheap prices for memory, and the horrible best case performance
for swap, an increase in swap performance should never, ever come at the
expense of performance for a system that has been sized such that executable
address spaces, libraries and anonymous memory will fit easily within
physical ram.

This of course doesn't address the VM paging storms that happen due to large
amounts of file system writes. Once the pagecache fills up, dirty pages must
be evicted from the pagecache so that new pages can be added to the
pagecache.

--Buddy



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Anthony DiSante
Sent: Tuesday, May 25, 2004 11:38 PM
To: linux-kernel@vger.kernel.org
Subject: why swap at all?

As a general question about ram/swap and relating to some of the issues in 
this thread:

	~500 megs cached yet 2.6.5 goes into swap hell

Consider this: I have a desktop system with 256MB ram, so I make a 256MB 
swap partition.  So I have 512MB "memory" and if some process wants more, 
too bad, there is no more.

Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not 
just disable my swap completely now?  I won't have increased my memory's 
size at all, but won't I have increased its performance lots?

Or, to make it more appealing, say I initially had 512MB ram and now I have 
1GB.  Wouldn't I much rather not use swap at all anymore, in this case, on 
my desktop?

-Anthony
http://nodivisions.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

