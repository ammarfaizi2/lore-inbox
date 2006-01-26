Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWAZKuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWAZKuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAZKuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:50:17 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:54490 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932266AbWAZKuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:50:16 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17368.43364.498958.823664@gargle.gargle.HOWL>
Date: Thu, 26 Jan 2006 13:50:12 +0300
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hancockr@shaw.ca
Subject: Re: sched_yield() makes OpenLDAP slow
Newsgroups: gmane.linux.kernel
In-Reply-To: <43D8889E.3020907@aitel.hist.no>
References: <MDEHLPKNGKAHNMBLJOLKAEJBJKAB.davids@webmaster.com>
	<43D8889E.3020907@aitel.hist.no>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting writes:

[...]

 > 
 > >nothing says that it can't call pthread_mutex_lock and re-acquire the mutex
 > >before any other thread gets around to getting it.
 > >  
 > >
 > Wrong.
 > The spec says that the mutex must be given to a waiter (if any) at the
 > moment of release.  The waiter don't have to be scheduled at that
 > point, it may keep sleeping with its freshly unlocked mutex.  So the
 > unlocking thread may continue - but if it tries to reaquire the mutex
 > it will find the mutex taken and go to sleep at that point. Then other

You just described a convoy formation: a phenomenon that all reasonable
mutex implementation try to avoid at all costs. If that's what standard
prescribes---the standard has to be amended.

 > 
 > Helge Hafting

Nikita.
