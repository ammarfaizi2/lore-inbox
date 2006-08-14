Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWHNNWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWHNNWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWHNNWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:22:04 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:61647 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751266AbWHNNWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:22:03 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Erik Slagter <erik@slagter.name>
cc: linux-kernel@vger.kernel.org
Subject: Re: md mirror / ext3 / dual core performance strange phenomenon? 
In-reply-to: Your message of "Mon, 14 Aug 2006 15:12:14 +0200."
             <1155561134.7809.27.camel@skylla.slagter.name> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 23:22:02 +1000
Message-ID: <10837.1155561722@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter (on Mon, 14 Aug 2006 15:12:14 +0200) wrote:
>Now, what puzzles me, is that compiling the kernel (2.6.17.7) using
>either "make -j1 ..." or "make -j2 ..." or "make -j3 ..." makes the
>building take about 6.5 minutes, which is really dissatisfying for this
>cpu/harddisks combination. Also, top shows that most of the time both
>core are between 10-40% idle.
>
>BUT... starting from -j4 (and upwards) the compile time suddenly goes to
>3.5 minutes!

Nothing to do with the disks, it is a design flaw in the kernel build
system.  If you want a useful parallel make using -j<n>, set <n> to 3,
4 or 5 higher than the real number of parallel jobs that you want.  The
exact value to add depends on which kernel tree you are building.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=115553906404695&w=2

