Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUCRTIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUCRTIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:08:09 -0500
Received: from ns.suse.de ([195.135.220.2]:11937 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262874AbUCRTIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:08:05 -0500
Subject: Re: 2.6.4-mm2
From: Chris Mason <mason@suse.com>
To: markw@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200403181849.i2IIn2E26720@mail.osdl.org>
References: <200403181849.i2IIn2E26720@mail.osdl.org>
Content-Type: text/plain
Message-Id: <1079637035.4183.2106.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 14:10:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 13:48, markw@osdl.org wrote:
> On 18 Mar, Andrew Morton wrote:
> > markw@osdl.org wrote:
> >>
> >> Sorry I'm falling behind...  I see about a 10% decrease in throughput
> >> with our dbt2 workload when comparing 2.6.4-mm2 to 2.6.3.  I'm wondering
> >> if this might be a result of the changes to the pagecache, radix-tree
> >> and writeback code since you mentioned it could affect i/o scheduling in
> >> 2.6.4-mm1.
> > 
> > Could be.  Have you run tests without LVM in the picture?
> 
> No I haven't and I'm hesitant to.  I have 52 single drives in one volume
> and 14 single drives the other.  Because it's PostgreSQL, my options are
> to either run on a single drive (and not be able to drive the system as
> hard) or to reconfigure my drives using hardware raid.  I could do the
> latter if you think it'll help.  It's just a bit time consuming.
> 
It might be more valuable to retest on 2.6.5-rc1-mm2.  I'm assuming
postgres was doing synchronous writes, and 2.6.4-mm2 doesn't really wait
correctly.

-chris


