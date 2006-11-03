Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753377AbWKCQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbWKCQuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbWKCQuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:50:06 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:8917 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1753377AbWKCQuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:50:04 -0500
Date: Fri, 3 Nov 2006 17:36:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Mark Williamson <mark.williamson@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, Michael Halcrow <mhalcrow@us.ibm.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
In-Reply-To: <84144f020611030113u119a3759q11a3ac4cfacccb74@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0611031735070.21864@yvahk01.tjqt.qr>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu> 
 <1162483565.6299.98.camel@lade.trondhjem.org>  <20061103032702.GB13499@filer.fsl.cs.sunysb.edu>
  <200611030345.51167.mark.williamson@cl.cam.ac.uk> 
 <20061103035130.GC13499@filer.fsl.cs.sunysb.edu>  <1162535103.5635.20.camel@lade.trondhjem.org>
 <84144f020611030113u119a3759q11a3ac4cfacccb74@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Why? What is so special about the details that you need to hide them?
>> This is a union that will always be part of a structure anyway.
>
> Nothing. Josef, I think we should make them unions.

In other words,

/* structs to maintain pointers to the lower VFS objects */
struct fsstack_sb_info {
	union {
		struct super_block *sb;
		struct super_block **sbs;
	};                                                                      
};                                                                         

should become:

union fsstack_sb_info {
	struct super_block *sb;
	struct super_block **sbs;
};


	-`J'
-- 
