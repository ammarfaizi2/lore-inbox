Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbREENkA>; Sat, 5 May 2001 09:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbREENju>; Sat, 5 May 2001 09:39:50 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:40466 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S132482AbREENjl>;
	Sat, 5 May 2001 09:39:41 -0400
Date: Sat, 5 May 2001 06:37:26 -0700
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010505063726.A32232@va.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

You can find a new version of the hot swap cpu patch at:

http://samba.org/~anton/patches/cpu_hotswap-2.4.3-patch

The version for s390 (you need to first apply the 2.4.3 kernel
patch available on the IBM s390 Linux website) is at:

http://samba.org/~anton/patches/cpu_hotswap-2.4.3-patch-s390

Many thanks to Heiko Carstens <Heiko.Carstens@de.ibm.com> for adding
s390 support and fixing a few bugs in the initial implementation.
You should be able to attach and detach CPUs depending on workload
in your s390 Linux guest images :)

One of the advantages of this patch is that it removes cpu_logical_map()
and cpu_number_map() which people had a tendency to get wrong.

It should also be easy to support more than BITS_PER_LONG cpus
as there is no concept of online_cpu_map any more.

Anton
