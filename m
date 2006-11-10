Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424304AbWKJA61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424304AbWKJA61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424322AbWKJA61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:58:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10210 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424304AbWKJA61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:58:27 -0500
Date: Fri, 10 Nov 2006 11:57:49 +1100
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061110005749.GO8394166@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611092218.58970.rjw@sisk.pl> <20061109214159.GB2616@elf.ucw.cz> <200611092321.47728.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611092321.47728.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 11:21:46PM +0100, Rafael J. Wysocki wrote:
> I think we can add a flag to __create_workqueue() that will indicate if
> this one is to be running with PF_NOFREEZE and a corresponding macro like
> create_freezable_workqueue() to be used wherever we want the worker thread
> to freeze (in which case it should be calling try_to_freeze() somewhere).
> Then, we can teach filesystems to use this macro instead of
> create_workqueue().

At what point does the workqueue get frozen? i.e. how does this
guarantee an unfrozen filesystem will end up in a consistent
state?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
