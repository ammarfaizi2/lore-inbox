Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUB0BMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUB0BMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:12:30 -0500
Received: from holomorphy.com ([199.26.172.102]:29966 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261724AbUB0BLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:11:55 -0500
Date: Thu, 26 Feb 2004 17:11:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jochen Roemling <jochen@roemling.net>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040227011151.GT693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jochen Roemling <jochen@roemling.net>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net> <403E958B.6020406@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E958B.6020406@roemling.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 01:55:39AM +0100, Jochen Roemling wrote:
> sounds good, but does not work either :-(
> roesrv01~ # compartment --cap CAP_IPC_LOCK bash
> bash-2.05b# /sbin/getpcaps 3226
> Capabilities for `3226': =ep cap_ipc_lock+i cap_setfcap-p cap_setpcap-ep
> bash-2.05b# su - jochen
> jochen@roesrv01:~> /sbin/getpcaps 3233
> Capabilities for `3233': = cap_ipc_lock+i
> jochen@roesrv01:~> ./a.out
> Failure:: Operation not permitted
> jochen@roesrv01:~> ps ax
> [...]
> 3226 pts/0    S      0:00 bash
> 3233 pts/0    S      0:00 -su

Check /proc/sys/vm/nr_hugepages and /proc/sys/kernel/shmmax also.


-- wli
