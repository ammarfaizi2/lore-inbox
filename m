Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272679AbRITPEg>; Thu, 20 Sep 2001 11:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274532AbRITPE1>; Thu, 20 Sep 2001 11:04:27 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:32005 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274531AbRITPEI>; Thu, 20 Sep 2001 11:04:08 -0400
Message-ID: <3BAA0515.9CC823A1@osdlab.org>
Date: Thu, 20 Sep 2001 08:02:45 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Shane Wegner <shane@cm.nu>, linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz> <20010919153441.A30940@cm.nu> <20010920004543.Z720@athlon.random> <20010919193128.A8650@cm.nu> <20010919193649.A8824@cm.nu> <20010920045235.N720@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Can you also resolve "c012e052" so we know who's allocating those pages
> just in case?

It's trivial to do that, of course, but if someone needs an
automated way to do it (several times, easy lookup), you can
try  http://www.osdlab.org/sw_resources/scripts/ksysmap .

Usage is:  ksysmap [system_map_file] offset

and it spits out address/symbol before offset, exact match if
present, and address/symbol after offset.

Example:

[rddunlap@dragon linux]$ ksysmap ./System.map-249acpi c012e052
ksysmap: searching './System.map-249acpi' for 'c012e052'

c012df20 T sys_truncate
c012e052 ..... <<<<<
c012e0a0 T sys_ftruncate

~Randy
