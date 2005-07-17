Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVGQRkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVGQRkh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVGQRkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:40:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7818 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261319AbVGQRkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:40:32 -0400
Subject: [RFC] [PATCH 0/4]Multiple block allocation and delayed allocation
	for ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Cc: Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com, tytso@mit.edu,
       alex@clusterfs.com, adilger@clusterfs.com
In-Reply-To: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Sun, 17 Jul 2005 10:40:02 -0700
Message-Id: <1121622002.4609.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, 

Here are the updated patches to support multiple block allocation and
delayed allocation for ext3 done by me, Badari and Suparna.

[PATCH 1/4] -- multiple block allocation for current ext3.
(ext3_get_blocks()).

[PATCH 2/4] -- adding delayed allocation for writeback mode

[PATCH 3/4] -- generic support for cluster pages together in
mapge_writepages() to make use of getblocks() 

[PATCH 4/4] -- support multiple block allocation for ext3 writeback mode
through writepages(). 


Have done initial testing on dbench and tiobench on a 2.6.11 version of
this patch set. Dbench 8 thread throughput result is increased by 20%
with this patch set.

dbench comparison: (ext3-dm represents ext3+thispatchset)
http://www.sudhaa.com/~ram/ols2005presentation/dbench.jpg
tiobench comparison:
http://www.sudhaa.com/~ram/ols2005presentation/tio_seq_write.jpg


Todo:
- bmap() support for delayed allocation
- page reserve flag to indicate the delayed allocation
- ordered mode support for delayed allocation
- "bh" support to enable blocksize = 1k/2k filesystems



Cheers,

Mingming


