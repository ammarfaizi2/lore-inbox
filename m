Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVCWAyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVCWAyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVCWAyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:54:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18322 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262674AbVCWAxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:53:45 -0500
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
From: Lee Revell <rlrevell@joe-job.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050323013729.0f5cd319.diegocg@gmail.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	 <20050314083717.GA19337@elf.ucw.cz>
	 <200503140855.18446.jbarnes@engr.sgi.com>
	 <20050314191230.3eb09c37.diegocg@gmail.com>
	 <1110827273.14842.3.camel@mindpipe>
	 <20050323013729.0f5cd319.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 22 Mar 2005 19:53:37 -0500
Message-Id: <1111539217.4691.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 01:37 +0100, Diego Calleja wrote:
> El Mon, 14 Mar 2005 14:07:53 -0500,
> Lee Revell <rlrevell@joe-job.com> escribió:
> 
> > I'm really not trolling, but I suspect if we made the boot process less
> > verbose, people would start to wonder more about why Linux takes so much
> > longer than XP to boot.
> 
> By the way, Microsoft seems to be claiming that boot time will be reduced to the half
> with Longhorn. While we already know how ms marketing team works, 50% looks
> like a lot. Is there a good place to discuss what could be done in the linuxland to
> improve things? It doesn't looks like a couple of optimizations will be enought...
> 

Yup, many people on this list seem unaware but read the XP white papers,
then try booting it side by side with Linux.  They put some serious,
serious engineering into that problem and came out with a big win.
Screw Longhorn, we need improve by 50% to catch up to what they can do
NOW.

The solution is fairly well known.  Rather than treating the zillions of
disk seeks during the boot process as random unconnected events, you
analyze the I/O done during the boot process, then lay out those disk
blocks optimally based on this information so on the next boot you just
do one big streaming read.  The patent side has been discussed and there
seems to be plenty of prior art.

Someone needs to just do it.  All the required information is right
there.

Lee

