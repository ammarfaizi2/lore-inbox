Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUBDVLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUBDVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:11:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43652 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264455AbUBDVIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:08:44 -0500
Date: Wed, 4 Feb 2004 13:08:39 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jfaulkne@ccs.neu.edu, linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
Message-Id: <20040204130839.1023c2f2.davem@redhat.com>
In-Reply-To: <20040204125444.3f2b5e79.akpm@osdl.org>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
	<Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
	<20040204125444.3f2b5e79.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004 12:54:44 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >   3 root      35  19     0    0    0 S 45.9  0.0   0:46.98 ksoftirqd/0
> >   6 root       5 -10     0    0    0 S 43.3  0.0   1:56.63 events/0
> >   12008 dogshu 15   0  4800 2356 3828 S  5.3  0.2   0:05.98 proftpd
> >   12 root      15   0     0    0    0 S  0.3  0.0   0:00.41 pdflush
> >   9778 root    16   0  5888 1724 5516 R  0.3  0.2   0:00.12 sshd
> > 
> > the load before that network transfer was 0.01, and the load after the
> > network transfer was 1.45.
> 
> Could be a networking problem, but boy that's a lot of CPU time.

Andrew maybe something bolixed in the MAX_SOFTIRQ_RESTART stuff
we put into kernel/softirq.c?  Just a guess...
