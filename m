Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTDXAsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTDXAsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:48:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18050 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264364AbTDXAr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:47:59 -0400
Date: Wed, 23 Apr 2003 17:49:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Pavel Machek <pavel@ucw.cz>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <1608070000.1051145373@flay>
In-Reply-To: <20030424002551.GA2980@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <1592050000.1051142225@flay> <20030424002551.GA2980@elf.ucw.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK ... but at least having the *option* to have a separate reserved
>> area would be nice, no? For most people, RAM is just a tiny amount
>> of their disk space ... and damn, does it make the code simpler ;-)
> 
> If it is an *option*, it does not make code simpler.
> 
> And OOM-killing during suspend is just what you want. It makes suspend
> deterministic but it might kill someone. [Well, your solution would
> kill him sooner than that...]

OK, fair enough. I like the "activate the spare swap blob" plan.
Seems like the best of both worlds ... people can use files or
partitions, and all the code is already there.

M.

