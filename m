Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTKZFxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 00:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTKZFxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 00:53:51 -0500
Received: from fmr05.intel.com ([134.134.136.6]:13544 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263963AbTKZFxt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 00:53:49 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: hash table sizes
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Wed, 26 Nov 2003 13:53:47 +0800
Message-ID: <3AA03342E913FA4BA6D8BD0732BFC74B041F8424@pdsmsx402.pd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hash table sizes
Thread-Index: AcOz3kDmMxayzrcxSc6FSfGoRuQBigAATZSg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Nov 2003 05:53:47.0936 (UTC) FILETIME=[A8E8FA00:01C3B3E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tcp/ip have the same problem. See function tcp_init/ip_rt_init.

My colleague's testing on IA64 shows the same result like Jef's while
tcp_establish hash table applies for about 1G memory! Actually, it seems
it wants to apply for 4G memory at the beginning!

It's not a good idea to find a smart formula to fit into all scenarios.
We can add new command line parameters to setup the hash table size,
such as dentry_ht_size/inode_ht_size/tcp_estab_ht_size/ip_rt_ht_szie. If
users don't input such parameters, then kernel can use Jes's formula to
work out the size. 

