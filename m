Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUHESOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUHESOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267858AbUHESMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:12:32 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33968 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267853AbUHESDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:03:11 -0400
Date: Thu, 5 Aug 2004 20:03:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu
Cc: arjanv@redhat.com, tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       crisw@osdl.org, jan.glauber@de.ibm.com
Subject: [RFC] cputime patches.
Message-ID: <20040805180308.GA9240@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
the cleanup of my cputime patches is done and now I'm ready for the
first round of bashing ;-)
I've split the kernel patch into 5 parts, Jan works on another kernel
patch that introduces virtual cpu time slices but this isn't ready yet.
Patch number 6 is a patch against procps that make the cpu steal field
visible. Patches number 1 to 3 are kernel code cleanups that make life
easier (I think), number 4 is the one that introduces the cputime
interface to common code and number 5 is s390 architecture code that
makes use of the interface to get exact cputime numbers.

The patches are against 2.6.8-rc3. I'll keep the fingers crossed
that I didn't break any architecture. Have fun.

[PATCH] cputime (1/6): move call to update_process_times.
[PATCH] cputime (2/6): remove unused definitions from timex.h.
[PATCH] cputime (3/6): move jiffies stuff to jiffies.h
[PATCH] cputime (4/6): introduce cputime.
[PATCH] cputime (5/6): microsecond based cputime for s390.
[PATCH] cputime (6/6): add cpu steal time fields to procps.

blue skies,
  Martin.

