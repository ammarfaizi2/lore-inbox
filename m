Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWFFX17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWFFX17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWFFX17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:27:59 -0400
Received: from gw.goop.org ([64.81.55.164]:46545 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751350AbWFFX17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:27:59 -0400
Message-ID: <44860F7B.2040105@goop.org>
Date: Tue, 06 Jun 2006 16:27:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Don Zickus <dzickus@redhat.com>, ak@suse.de, shaohua.li@intel.com,
       miles.lane@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org>	<1149576246.32046.166.camel@sli10-desk.sh.intel.com>	<20060606141755.GN2839@redhat.com>	<200606061618.15415.ak@suse.de>	<20060606214553.GB11696@redhat.com>	<20060606151507.613edaad.akpm@osdl.org>	<20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org>
In-Reply-To: <20060606162201.f0f9f308.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> All the above applies to suspend-to-disk.  I don't know if suspend-to-RAM
> shuts down the APs.
>   

I'm using suspend-to-mem and it looks like its unplugging/replugging all 
the CPUs.

The part of the question I don't quite understand is why this is 
considered per-CPU state?  Surely NMI-watchdog is a system-wide thing?  
Or does this also tie into other uses of the performance registers which 
may be set per-CPU?

    J
