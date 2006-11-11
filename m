Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161909AbWKKJLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161909AbWKKJLN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 04:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161911AbWKKJLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 04:11:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:37307 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161909AbWKKJLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 04:11:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [discuss] 2.6.19-rc5: known regressions (v2)
Date: Sat, 11 Nov 2006 10:08:37 +0100
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061111015035.GU4729@stusta.de>
In-Reply-To: <20061111015035.GU4729@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Paolo Ornati <ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111008.37986.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 11 November 2006 02:50, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc5 compared to 2.6.18
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : PCI MSI setting corrupted during resume
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7479
> Submitter  : Stephen Hemminger <shemminger@osdl.org>
> Status     : unknown
> 
> 
> Subject    : x86_64 boot failure: irq 22: nobody cared (hda_intel MSI)
> References : http://lkml.org/lkml/2006/11/8/98
> Submitter  : Olivier Nicolas <olivn@trollprod.org>
> Status     : unknown
> 
> 
> Subject    : SMP kernel can not generate ISA irq properly
> References : http://lkml.org/lkml/2006/10/22/15
>              http://lkml.org/lkml/2006/11/10/142
> Submitter  : Komuro <komurojun-mbn@nifty.com>
> Handled-By : Thomas Gleixner <tglx@linutronix.de>
> Status     : Thomas is investigating
> 
> 
> Subject    : x86_64: Fix partial page check to ensure unusable memory
>                      is not being marked usable
> References : http://lkml.org/lkml/2006/11/9/239
> Submitter  : Aaron Durbin <adurbin@google.com>
> Caused-By  : Mel Gorman <mel@csn.ul.ie>
>              commit 5cb248abf5ab65ab543b2d5fc16c738b28031fc0
> Patch      : http://lkml.org/lkml/2006/11/9/239
> Status     : patch available
> 
> 
> Subject    : x86_64: Bad page state in process 'swapper'
> References : http://lkml.org/lkml/2006/11/10/135
>              http://lkml.org/lkml/2006/11/10/208
> Submitter  : Andre Noll <maan@systemlinux.org>
> Handled-By : Andi Kleen <ak@suse.de>
> Status     : Andi is investigating
> 
> 
> Subject    : x86_64: oprofile doesn't work
> References : http://lkml.org/lkml/2006/10/27/3
> Submitter  : Prakash Punnoor <prakash@punnoor.de>
> Status     : unknown
> 
> 
> Subject    : weird battery charge level reported
>              ACPI Error method parse / execution failed
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7466
> Submitter  : Olivier Mondoloni <olivier.mondoloni@waika9.com>
> Status     : unknown
> 
> 
> Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
> References : http://lkml.org/lkml/2006/10/31/333
> Submitter  : Ernst Herzberg <earny@net4u.de>
> Handled-By : Len Brown <len.brown@intel.com>
> Status     : problem is being debugged
> 
> 
> Subject    : BUG: scheduling while atomic: events/0/0x00000001/4
>              after resume
> References : http://lkml.org/lkml/2006/11/2/209
> Submitter  : Paolo Ornati <ornati@fastwebnet.it>
> Status     : unknown

I couldn't find anything in the report that would indicate the problem occured
after a resume.  Was it really the case?

> Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
> Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
> Status     : unknown
> 
> 
> Subject    : libata must be initialized earlier
> References : http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027945.html
> Submitter  : Paul Mackerras <paulus@samba.org>
> Handled-By : Brian King <brking@us.ibm.com>
> Patch      : http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
> Status     : patch available
> 
> 
> Subject    : unable to rip cd
> References : http://lkml.org/lkml/2006/10/13/100
>              http://lkml.org/lkml/2006/11/8/42
> Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
> Handled-By : Jens Axboe <jens.axboe@oracle.com>
> Status     : Jens is investigating

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
