Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319247AbSHUXkt>; Wed, 21 Aug 2002 19:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319249AbSHUXks>; Wed, 21 Aug 2002 19:40:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38897 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319247AbSHUXks>; Wed, 21 Aug 2002 19:40:48 -0400
Subject: RE: Hyperthreading
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Banai Zoltan <bazooka@emitel.hu>, Kelsey Hudson <khudson@compendium.us>,
       James Bourne <jbourne@mtroyal.ab.ca>, Hugh Dickins <hugh@veritas.com>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000BA1E06E@fmsmsx103.fm.intel.com>
References: <F2DBA543B89AD51184B600508B68D4000BA1E06E@fmsmsx103.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 00:45:34 +0100
Message-Id: <1029973534.26411.258.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 23:56, Nakajima, Jun wrote:
> Since Pentium 4 and Xeon share the same core, you see the HT bit on Pentium
> 4 as well. The HT bit does not mean HT is enabled (you can enable/disable
> usually by the BIOS setup), but the number of the threads (i.e. logical
> CPUs) in a processor package must be 2 (via cpuid instruction) so that the
> OS can be sure that HT is enabled (see setup.c). The HT bit is just useful
> as a prerequisite for HT.

If you want to know the full HT capabilities of the processor you need
to read cpuid 1 and check ebx bits 16-23.

There has been some interesting speculation as to whether you can enable
HT by undocumented mtrrs on cpus that have "ht" but claim not to be
doing HT. Clearly the value returned is settable somewhere but I've seen
no proof yet than you can enable HT on non PIV Xeons this way.

