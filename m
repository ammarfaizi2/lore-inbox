Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbUKDJSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbUKDJSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUKDJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:18:41 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:24075 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S262139AbUKDJSX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:18:23 -0500
Date: Thu, 4 Nov 2004 10:12:20 +0100 (CET)
To: degger@fhm.edu
Subject: Re: dmi_scan on x86_64
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <ik4HgxjQ.1099559539.9911850.khali@gcu.info>
In-Reply-To: <E27340F4-2DFA-11D9-BF00-000A958E35DC@fhm.edu>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Andi Kleen" <ak@suse.de>, "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel,

> Is this stuff any relevant to a Tyan Tiger K8W (S2875), i.e. is Tyan
> employing the multiplexing trick on several boards or just the one you
> tried to identify?

The SMBus multiplexing is rarely used and highly board dependent. I have
no reason to believe that the Tyan Tiger K8W (S2875) has its SMBus
multiplexed (and if it were, it would require different, although
similar, code than I wrote for the S4882 anyway).

For reference, the only boards I know for sure use a form of multiplexing
for their hardware monitoring capabilities are the Iwill MPX2 and the
Gigabyte GA7 DPXDW+. Both use LM90 chips. One of them (can't remember
which) does true SMBus multiplexing over two of these, while the other
has a single chip which can be routed to either of two thermal diodes.
The sensors drivers don't support these setups yet.

I think I also remember of a board where fan inputs were somehow
multiplexed (the board had six fan headers, all of them reported speeds
in the BIOS setup screen, but the hardware monitoring chip would only
have three tachometers inputs.) I can't seem to remember the brand and
model, and we did not investigate the problem deep enough to propose a
solution back then anyway.

As a matter of fact, my proposal to support the S4882 SMBus multiplexing
is the first attempt to support this kind of setup. Note that other
proposals were already made but they were aimed at supporting home-made
setups, not publicly available motherboards.

--
Jean
