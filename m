Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVJGIE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVJGIE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVJGIE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:04:27 -0400
Received: from fmr16.intel.com ([192.55.52.70]:30658 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750942AbVJGIE0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:04:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] add sysfs to dynamically control blk request tag maintenance
Date: Fri, 7 Oct 2005 01:04:19 -0700
Message-ID: <B05667366EE6204181EABE9C1B1C0EB5086AEC32@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] add sysfs to dynamically control blk request tag maintenance
Thread-Index: AcXLEnc4sHzEg7JqRV6ujstS5D75TgAAEMcgAACL/mA=
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Oct 2005 08:04:22.0576 (UTC) FILETIME=[BA07EB00:01C5CB15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crap .... (my silly mail client doesn't line up tab correctly)
Repost the profile.

Latest execution profile taken with 2.6.14-rc2 kernel with "industry
standard transaction processing database workload".  First column is
clock ticks (a direct measure of time), 2nd column is instruction
retired, and 3rd column is number of L3 misses occurred inside the
function.

Symbol                  Clktick  Inst.
                                 Retired  L3 Misses
scsi_request_fn         8.12%    9.27%    11.18%
Schedule                6.52%    4.93%    7.26%
scsi_end_request        4.44%    3.59%    6.76%
__blockdev_direct_IO    4.28%    4.38%    3.98%
__make_request          3.59%    4.16%    3.47%
__wake_up               2.46%    1.56%    3.33%
dio_bio_end_io          2.14%    1.67%    3.18%
aio_complete            2.05%    1.27%    3.56%
kmem_cache_free         1.95%    1.70%    0.71%
kmem_cache_alloc        1.45%    1.84%    0.45%
put_page                1.42%    0.60%    1.27%
follow_hugetlb_page     1.41%    0.75%    1.27%
__generic_file_aio_read 1.37%    0.36%    1.68%
