Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSFVUv1>; Sat, 22 Jun 2002 16:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSFVUv0>; Sat, 22 Jun 2002 16:51:26 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:38109 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S316798AbSFVUvZ> convert rfc822-to-8bit; Sat, 22 Jun 2002 16:51:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Skip Gaede <sgaede@attbi.com>
Subject: Memory abuse with NFS Root filesystem?
Date: Sat, 22 Jun 2002 16:48:36 -0400
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206221648.36450.sgaede@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I have a Mac client that's running 2.4.19-pre10, XFree86 
(4.2.0) -query + Mozilla 1.0 and losing lots of size-2048 
buffers. The rate loss is approximately 1000 buffers/hour, 
no reaping of the cache is ever performed, and after 8 
hours or so, the system is unusable. I'm seeing this loss 
of memory after I boot with an initrd, get an IP address 
with dhclient and do a pivot_root onto the read-only NFS 
file system.

I can also boot the the client to a bash prompt on the
 local hard drive and then run XFree86 -query + Mozilla as
 before. Under these conditions, both with and without the
 local filesystem mounted RO, the size-2048 buffer
 utilization is nominal.

Local boot: slabinfo after 30 minutes:
size-2048      5   50  2048    3    25  1 

NFS Root: slabinfo after 15 & 60 minutes
size-2048   187 228  2048  94  114  1  (15 min)
size-2048   918 928  2048 460 464  1  (60 min)

Anyone ever seen or heard of this before? Any thoughts on
how to isolate this to a root cause?

Thanks,
Skip

-------------------------------------------------------

