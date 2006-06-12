Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWFLK7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWFLK7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWFLK7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:59:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751853AbWFLK7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:59:22 -0400
From: Neil Brown <neilb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 12 Jun 2006 20:58:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17549.18674.809648.549618@cse.unsw.edu.au>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Matti Aarnio <matti.aarnio@zmailer.org>, jdow <jdow@earthlink.net>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
In-Reply-To: message from Alan Cox on Monday June 12
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	<193701c68d16$54cac690$0225a8c0@Wednesday>
	<1150100286.26402.13.camel@tara.firmix.at>
	<1150106004.22124.155.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 12, alan@lxorguk.ukuu.org.uk wrote:
> 
> SPF *would* be wonderful if the users controlled SPF handling and
> someone fixed the forwarding flaws in it, but neither is the case today.
> 

The "forwarding flaws" are not flaws in SPF but in SMTP practice.
I suspect they grew out of the multi-hop days of UUCP and similar
protocols, but it isn't appropriate in todays Internet.

A forwarded email is a new message and shouldn't claim to be from the
original sender.

I rent a home and occasionally get mail for the landlords which I
redirect to them.  If I mis-direct it, it should really come back to
me rather than the original sender (though the current postal system
doesn't actually encourage that). Of course my landlord needs to trust
me, but if they didn't they would have told everybody their new
address (and they have told most people).

Forwarding systems *Shouldn't* simply forward the mail.  They should
re-send it from a new origin.  If it bounces, there are various thing
that can be done, from human interaction, or disabling the forward for
future email, allowing customers to register backup addresses, or
having web-access to bounced mail or whatever.

Yes, people have to change their forwarding practices to be fully SPF
compliant, but that is a case of it is broke, and should be fixed
anyway.

NeilBrown
