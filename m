Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUILIBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUILIBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268530AbUILIBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:01:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59389 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268529AbUILIAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:00:45 -0400
Date: Sun, 12 Sep 2004 00:59:41 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@localhost.localdomain
Reply-To: linuxram@us.ibm.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <pbadari@us.ibm.com>,
       Ram Pai <linuxram@us.ibm.com>
Subject: Re: [Patch 0/6]: Cleanup and rbtree for ext3 reservations in
 2.6.9-rc1-mm4
In-Reply-To: <1094862886.1637.7078.camel@w-ming2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0409120054510.7938-100000@localhost.localdomain>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Sep 2004, Mingming Cao wrote:

> On Tue, 2004-09-07 at 06:02, Stephen Tweedie wrote:
> > The patches in the following set contain several cleanups for ext3
> > reservations, fix a reproducable SMP race, and turn the per-superblock
> > linear list of reservations into an rbtree for better scaling.
> 
> > These changes have been in rawhide for a couple of weeks, and have
> > been undergoing testing both within Red Hat and at IBM.  
> > 
> 
> We have run several tests on this set of the reservation changes. We
> compared the results w/o reservation, rbtree based reservation vs link
> list based reservation. 

I have some more results at 
http://eaglet.rain.com/ram/seekwrite/seekwrite.html

In summary reservation code performs better than non-reservation. 
There is no clear winner while comparing link-based reservation v/s rbtree 
reservation.

RP

