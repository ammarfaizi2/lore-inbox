Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUCRTwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUCRTwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:52:40 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:17289 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262911AbUCRTvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:51:32 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3ish94vis.fsf@averell.firstfloor.org>
References: <1u7eQ-6Bz-1@gated-at.bofh.it> <1ue6M-45w-11@gated-at.bofh.it>
	 <1uofN-4Rh-25@gated-at.bofh.it> <1vRz3-5p2-11@gated-at.bofh.it>
	 <1vRSn-5Fc-11@gated-at.bofh.it> <1vS26-5On-21@gated-at.bofh.it>
	 <1wkUr-3QW-11@gated-at.bofh.it> <1wolx-7ET-31@gated-at.bofh.it>
	 <1woEM-7Yx-41@gated-at.bofh.it> <1wp8b-7x-3@gated-at.bofh.it>
	 <1wp8l-7x-25@gated-at.bofh.it> <1x0qG-Dr-3@gated-at.bofh.it>
	 <m3ish94vis.fsf@averell.firstfloor.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079639441.3101.291.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 18 Mar 2004 11:50:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 13:15, Andi Kleen wrote:
> Peter Zaitsev <peter@mysql.com> writes:
> >
> > Rather than changing design how time is computed I think we would better
> > to go to better accuracy - nowadays 1 second is far too raw.
> 
> Just call gettimeofday(). In near all kernels time internally does that
> anyways.

Right, 

gettimeofday() was much slower some years ago on some other Unix
Platform, which is why time() was used instead.

Now we just need to fix a lot of places (datatypes, prints etc) to move
to gettimeofday()



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

