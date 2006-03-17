Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWCQRFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWCQRFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWCQRFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:05:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932447AbWCQRFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:05:31 -0500
Subject: Re: ext3_ordered_writepage() questions
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@suse.cz>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060317005418.GY30801@schatzie.adilger.int>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316210424.GD29275@thunk.org>
	 <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316220545.GB18753@atrey.karlin.mff.cuni.cz>
	 <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
	 <20060317005418.GY30801@schatzie.adilger.int>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 12:05:10 -0500
Message-Id: <1142615110.3641.8.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-03-16 at 17:54 -0700, Andreas Dilger wrote:

> That way the journal could tell the MD RAID layer what blocks might
> need resyncing instead of having to scan the whole block device for
> inconsistencies.

The current md layer supports write-intent bitmaps to deal with this.

--Stephen


