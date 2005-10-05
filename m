Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVJENSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVJENSF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVJENSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:18:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43724 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965165AbVJENSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:18:04 -0400
Date: Wed, 5 Oct 2005 14:18:04 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: subbie subbie <subbie_subbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
Message-ID: <20051005131804.GD18448@gallifrey>
References: <20051005112558.GC18448@gallifrey> <20051005130817.98406.qmail@web30311.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005130817.98406.qmail@web30311.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3 (i686)
X-Uptime: 14:14:19 up 33 days,  1:40, 60 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* subbie subbie (subbie_subbie@yahoo.com) wrote:
> A single thread writing at 30MB/s is still not on par
> with 3ware's specs.
> 
> I see that you're also running RAID5 and in this case
> 3ware did report bad write performance on RAID5 and
> that was fixed with recent firmwares. 
> 
> The latest linux driver off their website also
> includes the latest firmware inside it and flashes the
> card upon load, make sure to use that.

I've got driver/firmware that is about 2months old that
certainly helped; prior to that I was getting card
timeouts (although I also upgraded the e1000 driver
at the same time so it might have been that rather
than the 3ware that helped).
(Note: I don't expect a driver to perform a dangerous
operation like firmware flashing on boot!)

> I'm getting a little over 50MB/s when writing to my
> RAID volume when completely idle, there's no reason
> why you should get less.

Well my ~30MB/s is sucking over gig ether and writing
in 10MB chunks; but still 50MB/s for RAID5 feels like
it sucks.

> I'll let you guys know once I try JBOD (as soon as all
> the data is moved away).

Nod.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
