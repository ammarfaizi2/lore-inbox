Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUJLUTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUJLUTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJLUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:19:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6057 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267725AbUJLUTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:19:46 -0400
Date: Tue, 12 Oct 2004 13:19:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, roland@redhat.com
Subject: Periodic posix timer support broke between 2.6.9-rc1 and 2.6.9-rc1-bk17
In-Reply-To: <Pine.LNX.4.58.0410062150310.18565@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410121315170.5785@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0410062150310.18565@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran some test programs and discovered that the periodic timer support
is broken. The timer is triggered once and then never again. Single shot
timers work fine. 2.6.9-rc1 is fine. The first kernel that I tested where
I noticed the breakage was 2.6.9-rc1-bk17. 2.6.9-rc2 and following all
cannot do periodic timer signals.

I looked through the changelog but I cannot see anything that would cause
the problem. Roland's patch surely could not have done this.

Will try to track this down further, time permitting...
