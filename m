Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUF2RjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUF2RjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUF2RjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:39:19 -0400
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:18331 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265825AbUF2RjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:39:16 -0400
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: FabF <fabian.frederick@skynet.be>
To: Jesse Stockall <stockall@magma.ca>
Cc: Debi Janos <debi.janos@freemail.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1088530069.8367.2.camel@localhost>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	 <1088530069.8367.2.camel@localhost>
Content-Type: text/plain
Message-Id: <1088530746.3598.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 29 Jun 2004 19:39:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 19:27, Jesse Stockall wrote:
> On Tue, 2004-06-29 at 09:20, Debi Janos wrote:
> > I am found an interesting (bug?) feature in kernels between
> > 2.6.7-mm1 and 2.6.7-mm4
> > 
> > Some web pages eg. 
> > 
> > http://www.hup.hu/
> > http://portal.fsn.hu/
> > http://wiki.hup.hu/
> > 
> > is unreachable with these kernels. If i try kernel versions
> > <= 2.6.7 everything is O.K. above-mentioned all web pages works.
> > 
> 
> I'm seeing the same thing after upgrading to 2.6.7-mm4, 2.6.7 vanilla
> does not exhibit the problem.
> 
> Also Azureus (Java Bittorrent client) crashes when it tries to open a
> network socket to begin downloading. Again problem does not exist with
> 2.6.7.
> 
> I'm going to try a few other kernel versions to see if I can find when
> this started.
Same behaviour.

Here's an ipv4 diff (2.6.6 FE2 vs 2.6.7mm3)

 ip_local_port_range|32768 61000
 ip_nonlocal_bind|0
 ip_no_pmtu_disc|0
+ip_queue_maxlen|1024
 tcp_abort_on_overflow|0
 tcp_adv_win_scale|2
 tcp_app_win|31
-tcp_bic|0
+tcp_bic|1
 tcp_bic_fast_convergence|1
 tcp_bic_low_window|14
+tcp_default_win_scale|7
 tcp_dsack|1
 tcp_ecn|0
 tcp_fack|1
 tcp_max_orphans|8192
 tcp_max_syn_backlog|1024
 tcp_max_tw_buckets|180000
-tcp_mem|48128 48640 49152
+tcp_mem|24576 32768 49152
+tcp_moderate_rcvbuf|1
 tcp_no_metrics_save|0
 tcp_orphan_retries|0
 tcp_reordering|3
 tcp_sack|1
 tcp_stdurg|0
 tcp_synack_retries|5
-tcp_syncookies|0
 tcp_syn_retries|5
 tcp_timestamps|1
 tcp_tw_recycle|0

Regards,
FabF

> 
> Jesse

