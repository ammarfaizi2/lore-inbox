Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTHTMLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbTHTMLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:11:44 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:31444 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S261944AbTHTMLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:11:43 -0400
Subject: Re: [OT] Connection tracking for IPSec
From: Christophe Saout <christophe@saout.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1061381498.4210.16.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 14:11:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, 2003-08-20 um 13.22 schrieb Felipe Alfaro Solana:

> When using IPSec, if I open up protocols 50 and 51, all IPSec-protected
> traffic passes through the firewall, but it's not checked against the
> connection tracking module. How can I configure iptables so an
> IPSec-protected packet, after being classified as IP protocol 50 or 51,
> loop back one more time to pass through the connection tracking module?

You're saying it's not honouring the netfilter rules at all?

I'm having a related problem here. I switched my small home
server/router to the 2.6 kernel and switched from klips(freeswan) to the
new in-kernel ipsec. Racoon is working fine as keying daemon but the
netfilter rules don't work anymore.

I'm using it to encrypt between a single server in the internet (not a
network) and my router at home. I want it to masquerade the traffic from
my internal home network to the other machine, just like if there was no
encrypted path.

It doesn't work. The traffic from my internal network goes out
masqueraded but unencrypted and the other machine answers, but
encrypted, and on the return path my router at home throws the packet
away because it doesn't know what to do with that packet.

With klips it was possible to apply netfilter rules before and after the
packets got encrypted, because there was an additional virtual device
(ipsec0) that catches the traffic before encryption (or after
decryption).

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

