Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbSJ1XvK>; Mon, 28 Oct 2002 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSJ1XvK>; Mon, 28 Oct 2002 18:51:10 -0500
Received: from smtp.comcast.net ([24.153.64.2]:53895 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261331AbSJ1XvJ>;
	Mon, 28 Oct 2002 18:51:09 -0500
Date: Mon, 28 Oct 2002 18:56:56 -0500
From: Tom Vier <tmv@comcast.net>
Subject: ipt_do_table unaligned traps Re: Linux 2.5.44-ac5
In-reply-to: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021028235656.GB345@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipt_do_table is making unaligned accesses.

/proc/cpuinfo:
cpu			: Alpha
cpu model		: EV56
cpu variation		: 7
cpu revision		: 0
cpu serial number	: 
system type		: Miata
system variation	: 0
system revision		: 0
system serial number	: 
cycle frequency [Hz]	: 499748139 est.
timer frequency [Hz]	: 1024.00
page size [bytes]	: 8192
phys. address bits	: 40
max. addr. space #	: 127
BogoMIPS		: 988.76
kernel unaligned acc	: 1428 (pc=fffffc0000a2e3a4,va=fffffc0000a8b204)
user unaligned acc	: 4 (pc=12000e6f8,va=120150e34)
platform string		: Digital Personal WorkStation 500au
cpus detected		: 1

from System.map-2.5.44-ac5:
fffffc0000a2e180 t ipt_error
fffffc0000a2e1e0 T ipt_do_table  <--- in there
fffffc0000a2e720 t find_inlist_lock

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
