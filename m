Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWJCHcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWJCHcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 03:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWJCHcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 03:32:19 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:28488 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030204AbWJCHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 03:32:19 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: ashwin.chaugule@celunite.com, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20061002005905.a97a7b90.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org> <1159774552.13651.80.camel@lappy>
	 <20061002005905.a97a7b90.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 09:32:02 +0200
Message-Id: <1159860723.13651.95.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 00:59 -0700, Andrew Morton wrote:

> IOW: does the patch help mem=96M;make -j5??

Its hardly swapping; I'll go back to mem=64M; make -j5
that got some decent swapping and still ~50% cpu.

-vanilla:

        Command being timed: "make -j5"
        User time (seconds): 2557.12
        System time (seconds): 1239.14
        Percent of CPU this job got: 87%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 1:12:36
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 50920
        Minor (reclaiming a frame) page faults: 8988166
        Voluntary context switches: 129759
        Involuntary context switches: 146431
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

-swap-token:

        Command being timed: "make -j5"
        User time (seconds): 2557.20
        System time (seconds): 1122.35
        Percent of CPU this job got: 86%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 1:10:54
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 56116
        Minor (reclaiming a frame) page faults: 8985073
        Voluntary context switches: 135533
        Involuntary context switches: 145494
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

