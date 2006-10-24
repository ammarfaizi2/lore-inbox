Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWJXPHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWJXPHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWJXPHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:07:09 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:52624 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S965054AbWJXPHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:07:07 -0400
Date: Tue, 24 Oct 2006 17:00:51 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Message-ID: <20061024150050.GA8766@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061022122355.GC3502@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061022122355.GC3502@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject: 2.6.19-rc2: known unfixed regressions (v3)
> 
> This email lists some known unfixed regressions in 2.6.19-rc2 compared 
> to 2.6.18 that are not yet fixed Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
>

skip, hope I didn't trim too much.

>
> Subject    : T60 stops triggering any ACPI events
> References : http://lkml.org/lkml/2006/10/4/425
>              http://lkml.org/lkml/2006/10/16/262
> Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : unknown

Just retested with 2.6.19-rc3 - it's still there:
e.g. after I do a full kernel compile, my T60 stops triggering any ACPI events:
tail -f /var/log/acpid does not show anything, even on Fn/F4 which is supposed
to be always enabled.  Restarting the acpid doesn't do anything either - ACPI
starts working again, for a while, only after reboot.

Works fine in 2.6.18 ( + this patch http://lkml.org/lkml/2006/7/20/56).

-- 
MST
