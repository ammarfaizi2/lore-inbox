Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWIJVe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWIJVe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWIJVe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:34:56 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:17063 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751128AbWIJVe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:34:56 -0400
Date: Sun, 10 Sep 2006 22:34:40 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, jeff@garzik.org, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
Message-ID: <20060910213440.GA9412@srcf.ucam.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain> <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain> <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain> <20060910002112.GA20672@kroah.com> <1157913647.5076.174.camel@mindpipe> <20060910204516.GA9036@srcf.ucam.org> <1157923819.5076.185.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157923819.5076.185.camel@mindpipe>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 05:30:18PM -0400, Lee Revell wrote:

> Sorry, all I have is anecdotal evidence.  The scope of the problem isn't
> fully known.  Could be related to vendors implementing ACPI using SMM.
> Vendors are tight lipped about which hardware is affected because it
> understandably annoys users.

I don't know what you really mean by "implementing ACPI" here. Certain 
queries may generate SMM traps, but I haven't seen any event driven code 
paths that do[1]. If you're polling hardware you may generate some 
latency, but I don't think that's any great surprise.

It would be interesting to have a test case under Linux so we could 
attempt to figure out whether it's an actual problem, or just Windows 
doing awkward things.

[1] outside sort of obvious stuff like ripping out a hotswap bay and 
/potentially/ critical battery status to switch on a warning light, but 
if you hit those situations you're probably pretty much dead anyway

-- 
Matthew Garrett | mjg59@srcf.ucam.org
