Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUGQVpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUGQVpv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 17:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUGQVpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 17:45:51 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:37310 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262062AbUGQVpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 17:45:50 -0400
Subject: Re: [RFC] Lock free fd lookup
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: kaos@ocs.com.au, wli@holomorphy.com, chrisw@osdl.org, jbarnes@engr.sgi.com,
       kiran@in.ibm.com, dipankar@in.ibm.com
Content-Type: text/plain
Organization: 
Message-Id: <1090091875.1232.456.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jul 2004 15:17:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> Writer vs. writer starvation on NUMA is a lot harder.  I don't know
> of any algorithm that handles lists with lots of concurrent updates
> and also scales well on large cpus, unless the underlying hardware
> is fair in its handling of exclusive cache lines.

How about MCS (Mellor-Crummey and Scott) locks?

Linux code:
http://oss.software.ibm.com/linux/patches/?patch_id=218

Something supposedly better:
http://user.it.uu.se/~zoranr/rh_lock/

Scott's list of 11 scalable synchronization algorithms:
http://www.cs.rochester.edu/u/scott/synchronization/pseudocode/ss.html

Scott's collection of papers and so on:
http://www.cs.rochester.edu/u/scott/synchronization/

Simply asking Scott might be a wise move. He'd likely know of anything
else that might fit the requirements. That's scott at cs.rochester.edu


