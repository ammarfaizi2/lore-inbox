Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWEBGOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWEBGOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEBGOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:14:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51626 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932388AbWEBGOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:14:06 -0400
Date: Tue, 2 May 2006 11:41:05 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jes@sgi.com, peterc@gelato.unsw.edu.au,
       efocht@ess.nec.de, lserinol@gmail.com, jlan@engr.sgi.com
Subject: [Patch 0/8] per-task delay accounting
Message-ID: <20060502061105.GK13962@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shailabh Nagar <nagar@watson.ibm.com>

Cc: Jes Sorensen <jes@sgi.com>,
    Peter Chubb <peterc@gelato.unsw.edu.au>,
    Erich Focht <efocht@ess.nec.de>,
    Levent Serinol <lserinol@gmail.com>,
    Jay Lan <jlan@engr.sgi.com>


Here are the delay accounting patches again. The patches are against
2.6.17-rc3

Andrew, could you please consider them for inclusion in -mm?

The previous posting of these patches is at
    http://www.ussg.iu.edu/hypermail/linux/kernel/0604.2/1831.html

Here's the list of the stakeholders identified by Andrew and a summary of
status of their comments.

1. CSA accounting/PAGG/JOB: Jay Lan <jlan@engr.sgi.com>

Raised several points
       http://www.ussg.iu.edu/hypermail/linux/kernel/0604.3/1036.html
all of which have been addressed in this set of patches.

2. per-process IO statistics: Levent Serinol <lserinol@gmail.com>

No reponse.
we have ascertained that its needs are a subset of CSA.

3. per-cpu time statistics: Erich Focht <efocht@ess.nec.de>

No response.
we have ascertained that its needs can be met by taskstats
interface whenever these statistics are submitted for inclusion.

4. Microstate accounting: Peter Chubb <peterc@gelato.unsw.edu.au>

Mentioned overlap of patches with delay accounting
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.3/2286.html

and also that a /proc interface was preferable due to convenience.
Our position is that the netlink interface is a superset of /proc due to
former's ability to supply exit-time data.


5. ELSA:  Guillaume Thouvenin <guillaume.thouvenin@bull.net>

Confirmed that ELSA is not a direct user of a new kernel statistics
interface since it is a consumer of CSA or BSD accounting's statistics.


6. pnotify: Jes Sorensen <jes@sgi.com>
(taken over pnotify from Erik Jacobson)

Informed over private email that pnotify replacement is
being worked on.

we have ascertained that pnotify (or its replacemenent) will not be
concerned with exporting data to userspace or collecting any stats.
Thats left to the kernel module that uses pnotify to get
notifications. CSA is one expected user of pnotify.
Hence CSA's concerns are the only ones relevant to pnotify as well.


7. Scalable statistics counters with /proc reporting:
 Ravikiran G Thirumalai, Dipankar Sarma <dipankar@in.ibm.com>

Confirmed these counters aren't relevant to this discussion.

Balbir


Series

delayacct-setup.patch
delayacct-blkio-swapin.patch
delayacct-schedstats.patch
genetlink-utils.patch
taskstats-setup.patch
delayacct-taskstats.patch
delayacct-doc.patch
delayacct-procfs.patch
-- 
					<---	Balbir
