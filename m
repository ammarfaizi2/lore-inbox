Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWFFHVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWFFHVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWFFHVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:21:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:8842 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932134AbWFFHVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:21:42 -0400
Subject: Re: 2GB MMC/SD cards
From: Richard Purdie <rpurdie@rpsys.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk
Cc: Jordan Crouse <jordan.crouse@amd.com>
In-Reply-To: <20060605222908.GC4996@cosmic.amd.com>
References: <4481FB80.40709@drzeus.cx>
	 <20060605222908.GC4996@cosmic.amd.com>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 08:17:00 +0100
Message-Id: <1149578221.5520.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 16:29 -0600, Jordan Crouse wrote:
> I'm not 100% sure what the community stance is on using the simplified specs.
> I do believe the answer lies definitively within, but I'll refrain from
> quoting it to avoid any legal complaints.  For the longest time, my gut
> feeling has been that 512 byte writes were always accepted - but since all of
> our 2G and 4G cards support WRITE_BL_PARTIAL, we haven't had a chance to 
> prove the argument one way or the other.
> 
> We first heard about very large card issues from one of our customers, and
> we haven't heard any more problems since we gave them a patch to force the
> sector size on all SD/MMC cards to 512 bytes.  Thats just anecdotal evidence,
> but it is food for thought.

For what its worth this is the feeling I get from the users of the
Zaurus kernels as well. For the PXA driver, there is the added
complication that it doesn't support block sizes > 1023 but I've had no
complaints since I limited it to 512.

Richard

