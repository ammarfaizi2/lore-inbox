Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUHFP7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUHFP7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268173AbUHFP6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:58:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268140AbUHFPtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:49:51 -0400
Message-ID: <4113A839.40603@pobox.com>
Date: Fri, 06 Aug 2004 11:48:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <1091226922.5083.13.camel@localhost.localdomain> <410AEDC8.6030901@pobox.com> <410FCF9A.0@rtr.ca>
In-Reply-To: <410FCF9A.0@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> I'm the dude responsible for the infamous "50 milliseconds" here.
> 
> I agree that (1) it is overkill, (2) it could be optimised,
> and (3) it is very very non-standard.
> 
> But it also works extraordinarilly well.  I still am very active
> with ATA and SATA driver development, and the basic Linux IDE probe
> works for me on vendor hardware where their own standards-specific
> routines sometimes fail (even in their windows drivers).
> 
> If possible, it would be best to let it be, and over time it will
> be less and less important as SATA and kin take over the universe.

Honestly, this is what I would prefer:  leave drivers/ide probing alone. 
    As we say in the South, "if it ain't broke, don't fix it"

Long term, migrate to libata which should provide quite rapid PATA probing.


> One possibility here would be to augment it with reset signature probing,
> and/or a cyl-high read/write test.  These could speed things up for
> more mainstream cases.  But I'm not going to touch what's there myself!

libata already does this :)

	Jeff


