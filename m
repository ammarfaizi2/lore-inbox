Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSJERxQ>; Sat, 5 Oct 2002 13:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262427AbSJERxQ>; Sat, 5 Oct 2002 13:53:16 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:14351
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262425AbSJERxP>; Sat, 5 Oct 2002 13:53:15 -0400
Subject: Re: 2.5.40 (BK of today) vmstat SIGSEGV after reading /proc/stat
From: Robert Love <rml@tech9.net>
To: Patrick Mau <mau@oscar.prima.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005171245.GA3060@oscar.dorf.de>
References: <20021005171245.GA3060@oscar.dorf.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 13:59:20 -0400
Message-Id: <1033840762.909.3669.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 13:12, Patrick Mau wrote:

> The BK tree of today changed the data returned in /proc/stat.
> A 'vmstat -n 10' immediatly segfaults after reading ...
> 
> open("/proc/stat", O_RDONLY)            = 6
> read(6, "cpu  404408 506514 8240 154301 1"..., 4095) = 714
> close(6)                                = 0
> --- SIGSEGV (Segmentation fault) ---
> +++ killed by SIGSEGV +++

The format changed, on purpose.  You need vmstat from a newer version of
procps.  The newest version (2.0.9) and CVS dumps as-of yesterday are
available at:

	http://tech9.net/rml/procps

as both tarballs and RPM packages.

	Robert Love

