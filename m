Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266055AbUFJFgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUFJFgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 01:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUFJFgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 01:36:13 -0400
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:5826 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S266055AbUFJFgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 01:36:11 -0400
Message-ID: <40C7F347.9090107@bigpond.net.au>
Date: Thu, 10 Jun 2004 15:36:07 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>
Subject: [PATCH][2.6.7-rc3] Single Priority Array CPU Scheduler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
 > The single priority array scheduler (SPA) is a patch that simplifies
 > the O(1) scheduler while maintaining its good scalability and
 > interactive response characteristics. The patch comes as four sub
 > patches to simplify perusal of the changes:

An updated version of this scheduler is now available for 2.6.7-rc3 at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc3-SPA-v0.1>
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc3-SPA_IAB-v0.1>
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc3-SPA_TPB-v0.1>
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc3-SPA_TSTATS-v0.1>

These patches should be applied in the order that they are listed.

Also, as promised, the first of these patches has been unified with the 
staircase scheduler and a patch that implements the staircase scheduler 
on top of the first of the above patches is available at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc3-SPA_STAIRCASE-v0.1>

This scheduler is functionally equivalent to Con Kolivas's v6.4 
scheduler except that a promotion feature (that will trigger very 
infrequently probably never :-)) has been added.  This was added 
because, although it is extremely unlikely, starvation is possible with 
the staircase scheduler and this feature removes that possibility.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

