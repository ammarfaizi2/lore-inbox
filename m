Return-Path: <linux-kernel-owner+w=401wt.eu-S1030509AbXAMMID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbXAMMID (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 07:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbXAMMID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 07:08:03 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:55246 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030509AbXAMMIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 07:08:01 -0500
Message-ID: <45A8CB9F.3020506@s5r6.in-berlin.de>
Date: Sat, 13 Jan 2007 13:07:59 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>            <20070112150349.GI17269@csclub.uwaterloo.ca> <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
In-Reply-To: <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/2007 4:38 AM, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 12 Jan 2007 10:03:49 EST, Lennart Sorensen said:
>> I believe the closest optimization for a Core2 is probably the Pentium M
>> (certainly not the P4/netburst).  Not entirely sure though.
> 
> CONFIG_MCORE2=y
> 
> That's probably even closer :)  At least in 2.6.20-rc4-mm1.  

Here is some more information, not about kernel configuration parameters
but more generally about gcc flags to be used with Core and Core 2 CPUs:
http://www.gentoo.org/news/en/gwn/20061211-newsletter.xml#doc_chap2_sect3

Quoting their source, http://psykil.livejournal.com/2006/12/03/:
| If you're using GCC 4.1, use -march=prescott for Intel Core Solo/Duo
| and -march=nocona (and an amd64 profile) for Core 2 Solo/Duo.  For GCC
| 4.2, a Core Solo/Duo should use -march=prescott -mtune=generic, and
| Core 2 Solo/Duo should be set to -march=nocona -mtune=generic.  GCC
| trunk adds -march=core2 and support for the SSSE3 instruction set, but
| that won't be out for quite a while yet.
|
| If you do happen to be using GCC 4.2, check out the very cool
| -march=native, which will autodetect the host processor(s) and set
| -march and -mtune accordingly. For Core CPU's you'll also need the
| patch from GCC PR #30040.

-- 
Stefan Richter
-=====-=-=== ---= -==-=
http://arcgraph.de/sr/
