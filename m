Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVIYVWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVIYVWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 17:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVIYVWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 17:22:20 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:28922 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932295AbVIYVWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 17:22:20 -0400
Message-ID: <433713CD.5050607@austin.rr.com>
Date: Sun, 25 Sep 2005 16:17:01 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Subject: cifs writepages patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking at and testing Shaggy's cifs writepages patches, and 
they look promising.

 From my fastest test client to a laptop running Windows XP as a test 
server (unfortunately this means running against a relatively slow disk, 
but the file size should fit in cache on the server) here are some 
initial results (at least three runs at each size).  Doing large file 
copy (dd if=/dev/zero bs=16K count=4K of =/mnt/testfile) of 64Mbytes

Over 100Mbit Ethernet
w/o the patch (writes will go 4K):   6.1 MB/sec
w/patch and wsize 16K (default)  8.8MB/sec
w/patch and wsize reduced to 4K 6.3MB/sec
w/patch and wsize 8K 8.5 MB/sec
w/patch and wsize increased to 32K  9.8 MB/sec



