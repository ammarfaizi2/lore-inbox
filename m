Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbUKPUfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUKPUfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKPUdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:33:18 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:41182 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261783AbUKPUcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:32:00 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16794.25535.97260.366902@thebsh.namesys.com>
Date: Tue, 16 Nov 2004 23:31:59 +0300
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: pthread_cond_signal not waking thread
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJMEILFHAA.aathan-linux-kernel-1542@cloakmail.com>
References: <20041116104821.GA31395@elte.hu>
	<OMEGLKPBDPDHAGCIBHHJMEILFHAA.aathan-linux-kernel-1542@cloakmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew A. writes:
 > 
 > 
 > Below is a sysrq-t dump (relevant process is called "tt1"), and a
 > post I sent to ACE user group describing a situation I am seeing
 > where a pthread_cond_signal() call sometimes does not wake up the
 > thread waiting on the condition variable, despite a call to
 > sched_yield() following the pthread_cond_signal().  All threads are
 > running at equal priorities under SCHED_RR.
 > 

I experienced similar thing. Switching to the latest
http://linux.bkbits.net/linux-2.5 (done about 10 hours ago), (as advised
by Arjan van de Ven) fixed it.

Nikita.
