Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWCQXXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWCQXXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWCQXXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:23:13 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:21441 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751167AbWCQXXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:23:12 -0500
Subject: Re: ext3_ordered_writepage() questions
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jan Kara <jack@suse.cz>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1142635097.15257.49.camel@dyn9047017100.beaverton.ibm.com>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316210424.GD29275@thunk.org>
	 <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316220545.GB18753@atrey.karlin.mff.cuni.cz>
	 <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
	 <20060317005418.GY30801@schatzie.adilger.int>
	 <1142615110.3641.8.camel@orbit.scot.redhat.com>
	 <1142631141.15257.40.camel@dyn9047017100.beaverton.ibm.com>
	 <1142634134.3641.56.camel@orbit.scot.redhat.com>
	 <1142635097.15257.49.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 17 Mar 2006 15:23:08 -0800
Message-Id: <1142637789.4802.34.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 14:38 -0800, Badari Pulavarty wrote:
> On Fri, 2006-03-17 at 17:22 -0500, Stephen C. Tweedie wrote:

> > There is one other perspective to be aware of, though: the current
> > behaviour means that by default ext3 generally starts flushing pending
> > writeback data within 5 seconds of a write.  Without that, we may end up
> > accumulating a lot more dirty data in memory, shifting the task of write
> > throttling from the filesystem to the VM.  
> 
> Hmm.. You got a point there. 
> 
> > 
> > That's not a problem per se, just a change of behaviour to keep in mind,
> > as it could expose different corner cases in the performance of
> > write-intensive workloads.
> > 
> > --Stephen
> > 
> > 
> 

Current data=writeback mode already behaves like this, so the VM
subsystem should be tested for a certain extent, isn't?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

