Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTAUFBX>; Tue, 21 Jan 2003 00:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTAUFBX>; Tue, 21 Jan 2003 00:01:23 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:2944 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261799AbTAUFBW>; Tue, 21 Jan 2003 00:01:22 -0500
Subject: Re: spinlock efficiency problem [was 2.5.57 IO slowdown with
	CONFIG_PREEMPT enabled)
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Joe Korty <joe.korty@ccur.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301202258.WAA02263@rudolph.ccur.com>
References: <200301202258.WAA02263@rudolph.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043119361.13344.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 03:22:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 22:58, Joe Korty wrote:
> The new, preemptable spin_lock() spins on an atomic bus-locking
> read/write instead of an ordinary read, as the original spin_lock
> implementation did.  Perhaps that is the source of the inefficiency
> being seen.

Its a fairly critical "Never do this" on older intel processors and
kills the box very efficiently so your diagnosis is extremely 
plausible

