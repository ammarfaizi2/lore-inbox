Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUF1TSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUF1TSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUF1TSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:18:53 -0400
Received: from mail.enyo.de ([212.9.189.167]:30474 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S265134AbUF1TSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:18:52 -0400
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu>
	<20040625150532.1a6d6e60.davem@redhat.com> <40DCDDF4.7030509@tomt.net>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Mon, 28 Jun 2004 21:18:48 +0200
In-Reply-To: <40DCDDF4.7030509@tomt.net> (Andre Tomt's message of "Sat, 26
 Jun 2004 04:22:44 +0200")
Message-ID: <87zn6njxt3.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andre Tomt:

> I have not seen anything conclusive on this yet. How sensitive is
> Linux to the attack?

The original RST-based attack was against a mixed Cisco/Linux+Quagga
environment, IIRC.  This combination is especially vulnerable if the
BGP connection is established in the right direction.

However, nobody has probably bothered to replicate that attack in the
lab.  As published, the attack just doesn't work against Cisco/Cisco
peerings.  Unfortunately, there is another that *might* actually work,
that's why there was so much fuss about it.

If you have some window checking bugs (like the BSDs had), it can be
quite worse, of course.  But such issues are usually way overrated.
Most DoS potential remains unexploited anyway, and I don't think the
disruption from people frantically enabling the TCP MD5 option payed
off in the end.
