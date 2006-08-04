Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWHDI04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWHDI04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHDI0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:26:55 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:10461 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1030196AbWHDI0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:26:55 -0400
Date: Fri, 4 Aug 2006 10:26:37 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Futex BUG in 2.6.18rc2-git7
Message-ID: <20060804082637.GA19493@aepfle.de>
References: <200608040917.00690.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200608040917.00690.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 09:17:00AM +0200, Andi Kleen wrote:
> 
> One of my test machines (single socket core2 duo) running 2.6.18rc2-git7 over night 
> under moderate load threw this, followed by an endless loop of soft lockup timeouts
> (one exemplar appended)
> 
> I assume it is related to the new PI mutexes.

Maybe triggered by this, if it was from wagner.suse.de:

(glibc mainline make check):
GCONV_PATH=/usr/src/packages/BUILD/glibc-2.4/cc-nptl/iconvdata LC_ALL=C   /usr/src/packages/BUILD/glibc-2.4/cc-nptl/elf/ld-linux.so.2 --library-path /usr/src/packages/BUILD/glibc-2.4/cc-nptl:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/math:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/elf:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/dlfcn:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/nss:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/nis:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/rt:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/resolv:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/crypt:/usr/src/packages/BUILD/glibc-2.4/cc-nptl/nptl /usr/src/packages/BUILD/glibc-2.4/cc-nptl/nptl/tst-robustpi8  > /usr/src/packages/BUILD/glibc-2.4/cc-nptl/nptl/tst-robustpi8.out
Read from remote host wagner: Connection reset by peer

