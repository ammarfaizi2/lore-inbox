Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUIOU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUIOU43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUIOUzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:55:13 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:28038 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S267409AbUIOUtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:49:42 -0400
Date: Wed, 15 Sep 2004 22:44:30 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040915204430.GA11547@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com> <20040915114430.GA28143@k3.hellgate.ch> <20040915200230.GA13621@k3.hellgate.ch> <20040915202028.GV9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915202028.GV9106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 13:20:28 -0700, William Lee Irwin III wrote:
> > Ignore the absolute values (I requested each field individually for all
> > processes on my workstation, 1000 times). The cost of walking all vmas
> > for VmData & Co. is very visible.
> 
> Try this again after applying my updates, which make it equivalent to the
> algorithms used internally by fs/proc/task_mmu.c.

Here you go:

Testing all process fields, best out of 10
FieldID    CPU (s)  Wall (s) Label
0x03000002 0.130000 0.208989 NOP
0x21000100 0.150000 0.222867 Name
0x22000105 0.140000 0.216126 PID
0x22000109 0.140000 0.218058 UID
0x22000117 0.140000 0.231467 VmSize
0x22000118 0.140000 0.227863 VmLock
0x22000119 0.140000 0.229867 VmRSS
0x22000120 0.140000 0.226822 VmData
0x22000121 0.140000 0.228589 VmStack
0x22000122 0.130000 0.229107 VmExe
0x22000123 0.140000 0.228584 VmLib
0x23000421 0.140000 0.230716 wchan
