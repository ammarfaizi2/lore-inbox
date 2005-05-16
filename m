Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVEPNuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVEPNuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVEPNuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:50:18 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:64261 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261639AbVEPNtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:49:01 -0400
Message-ID: <4288A4CA.7000009@rtr.ca>
Date: Mon, 16 May 2005 09:48:58 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux does not care for data integrity
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org>
In-Reply-To: <20050516110203.GA13387@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >To make this explicit and unmistakable, Linux should be ashamed of
 >having put its users' data at risk for as long as it has existed, and
 >looking at how often I still get "barrier synch failed", it still does
 >with the kernel SUSE Linux 9.3 shipped with.

With ATA drives, this is strictly a userspace "policy" decision.

Most of us want longer lifespan and 2X the performance from our hardware,
and use UPSs to guarantee continuous power & survivability.

Others want to live more dangerously on the power supply end,
but still be safe on the filesystem end -- no guarantees there,
even with "hdparm -W0" to disable the on-drive cache.

Pulling power from a writing drive is ALWAYS a bad idea,
and can permanently corrupt the track/cylinder that was being
written.  This will toast a filesystem regardless of how careful
or proper the write flushes were done.

Write caching on the drive is not as big an issue as
good reliable power for this.

Cheers
