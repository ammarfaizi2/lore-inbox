Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWAIOpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWAIOpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWAIOpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:45:24 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:3743 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S964770AbWAIOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:45:23 -0500
Date: Mon, 9 Jan 2006 15:45:22 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-ID: <20060109144522.GB10955@vanheusden.com>
References: <20060108114305.GA32425@vanheusden.com>
	<20060109041114.6e797a9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109041114.6e797a9b.akpm@osdl.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Jan 10 15:23:51 CET 2006
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My system freezes (crashes) when I run tcpdump on the interface
> >  connected to a 3c905b card.
> Works for me with a 3c980-TX.  I can dig out a 905b.
> Please send the exact commands which you're using to demonstrate this -
> sufficient info for me to get as close as possible to what you're doing.

The exact command is:
tcpdump -i eth1

Yes, it is that simple. Not only tcpdump gives this problem; iftop as
well.

> Have you tried enabling the NMI watchdog?  Enable CONFIG_X86_LOCAL_APIC and
> boot with `nmi_watchdog=1' on the command line, make sure that the NMI line
> of /proc/interrupts is incrementing.

I'll give it a try. I've added it to the append-line in the lilo config.
Am now compiling the kernel.


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
