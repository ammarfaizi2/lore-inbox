Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUAITFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAITFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:05:37 -0500
Received: from fmr05.intel.com ([134.134.136.6]:49798 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262965AbUAITFb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:05:31 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Limit hash table size
Date: Fri, 9 Jan 2004 11:05:12 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB5802444@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Limit hash table size
Thread-Index: AcPWvRKJ7KVzyQzAQc+hl0y8UWwqvQAHsMZg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Anton Blanchard" <anton@samba.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 09 Jan 2004 19:05:16.0469 (UTC) FILETIME=[84750E50:01C3D6E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

>Have you done any analysis of hash depths of large memory machines? We
>had some extremely deep pagecache hashchains in 2.4 on a 64GB machine.
>While the radix tree should fix that, whos to say we cant get into a
>similar situation with the dcache?

We don't have any data to justify any size change for x86, that was the
main reason we limit the size by page order.  


>Check out how deep some of the inode hash chains are here:
>http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0105.html

If I read them correctly, most of the distribution is in the first 2
buckets, so it doesn't matter whether you have 100 buckets or 1 million
buckets, only first 2 are being hammered hard.  So are we wasting memory
on the buckets that are not being used?

- Ken
