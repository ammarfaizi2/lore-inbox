Return-Path: <linux-kernel-owner+w=401wt.eu-S1751731AbWLOAgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWLOAgR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWLOAgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:36:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42003 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731AbWLOAgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:36:16 -0500
Date: Fri, 15 Dec 2006 00:44:33 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata-pata with ICH4, rootfs
Message-ID: <20061215004433.590b592d@localhost.localdomain>
In-Reply-To: <200612141832.50587.s0348365@sms.ed.ac.uk>
References: <200612141714.55948.s0348365@sms.ed.ac.uk>
	<20061214182010.477073a9@localhost.localdomain>
	<200612141832.50587.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 18:32:50 +0000
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> Correct me if I'm wrong, but SATA wasn't available on ICH4. Only 5 and 
> greater. The kernel help text agrees with me.
> 
> My IDE controller usually works with CONFIG_BLK_DEV_PIIX; I was interested in 
> using your pata_xxx drivers in replacement, assuming there was support.

The ata_piix driver does both SATA and PATA for the later chips. The
reason for this is that the SATA ICH devices have PATA ports as well
which are closely interlinked in how they operate. Since the ata_piix
driver has to drive those and the PATA only ones from PIIX3 onward are
similar it handles them all.

Alan

