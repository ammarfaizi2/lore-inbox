Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285308AbRLNBgy>; Thu, 13 Dec 2001 20:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285305AbRLNBgn>; Thu, 13 Dec 2001 20:36:43 -0500
Received: from ns.suse.de ([213.95.15.193]:62990 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285309AbRLNBga>;
	Thu, 13 Dec 2001 20:36:30 -0500
Date: Fri, 14 Dec 2001 02:36:29 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
Cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <large-discuss@lists.sourceforge.net>,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, <rusty@rustcorp.com.au>
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
In-Reply-To: <20011213161734.5B4F.K-SUGANUMA@mvj.biglobe.ne.jp>
Message-ID: <Pine.LNX.4.33.0112140218440.27641-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Kimio Suganuma wrote:

> There is no /proc/sys/cpu directory on the latest kernel, and
> I guess someone is thinking the structure under the directory,
> right?

The current /proc/sys/cpu/ sysctls have been added as part of
Russell's cpu frequency scaling work. Currently, only the ARM
specific bits are merged. There are generic bits and x86 bits
waiting to be merged at some point..

The x86 part of this work uses the same framework, and was
done by myself and Arjan van de Ven. It's almost in a state
ready for merging also.

If you're interested in looking at this, it's in cvs..
cvs -d:pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
cvs -d:pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot checkout
cpufreq

> echo 1 > /proc/sys/cpu/<cpu-id>/online
>   or
> Which is the right way?

This one looks most sensible to me, and fits in with the
current scheme nicely.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

