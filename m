Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031086AbWI0WCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031086AbWI0WCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031090AbWI0WCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:02:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1031088AbWI0WCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:02:37 -0400
Message-ID: <451AF4B5.1090607@sandeen.net>
Date: Wed, 27 Sep 2006 17:01:25 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Kleikamp <shaggy@austin.ibm.com>, Jan Kara <jack@suse.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
References: <20060901101801.7845bca2.akpm@osdl.org>	<1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>	<20060906124719.GA11868@atrey.karlin.mff.cuni.cz>	<1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>	<20060906153449.GC18281@atrey.karlin.mff.cuni.cz>	<1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>	<20060906162723.GA14345@atrey.karlin.mff.cuni.cz>	<1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>	<20060906172733.GC14345@atrey.karlin.mff.cuni.cz>	<1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>	<20060907223048.GD22549@atrey.karlin.mff.cuni.cz>	<1158179120.11112.2.camel@kleikamp.austin.ibm.com> <20060913203817.b6711381.akpm@osdl.org>
In-Reply-To: <20060913203817.b6711381.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 13 Sep 2006 15:25:19 -0500
> Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> 
>>> +void journal_do_submit_data(struct buffer_head **wbuf, int bufs)
>> Is there any reason this couldn't be static?
> 
> Nope.

With this change, journal_brelse_array can also be made static in
recovery.c, and removed from jbd.h, I think.

-Eric
