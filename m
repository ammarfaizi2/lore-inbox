Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWBVShV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWBVShV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBVShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:37:21 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:22418 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750810AbWBVShT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:37:19 -0500
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and
	mpage_readpages()
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
In-Reply-To: <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 12:37:17 -0600
Message-Id: <1140633437.9912.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 08:58 -0800, Badari Pulavarty wrote:
> Thanks. Only current issue Nathan raised is, he wants to see
> b_size change to u64 (instead of u32) to support really-huge-IO
> requests. Does this sound reasonable to you ?

Didn't someone point out that size_t would make more sense?  There's no
reason for a 32-bit architecture to have a 64-bit b_size.

> Thanks,
> Badari

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

