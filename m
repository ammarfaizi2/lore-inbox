Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272232AbTGYRqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTGYRqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:46:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:38093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272232AbTGYRqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:46:30 -0400
Date: Fri, 25 Jul 2003 10:58:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, ecki-lkm@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
Message-Id: <20030725105818.6bc97653.rddunlap@osdl.org>
In-Reply-To: <200307251355.22161.jeffpc@optonline.net>
References: <E19fqMF-0007me-00@calista.inka.de>
	<200307251223.51849.jeffpc@optonline.net>
	<20030725102043.724f4a3b.rddunlap@osdl.org>
	<200307251355.22161.jeffpc@optonline.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 13:55:14 -0400 Jeff Sipek <jeffpc@optonline.net> wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| On Friday 25 July 2003 13:20, Randy.Dunlap wrote:
| > Yes, a common solution for this is to use some SNMP agent that does
| > 64-bit counter accumulation.
| 
| Interesting...I haven't thought of SNMP.
| 
| > IETF expects that some high-speed interfaces will have 64-bit
| > counters.  From RFC 2233 (Interfaces Group MIB using SMIv2):
| >
| > <quote>
| > For interfaces that operate at 20,000,000 (20 million) bits per
| > second or less, 32-bit byte and packet counters MUST be used.
| > For interfaces that operate faster than 20,000,000 bits/second,
| > and slower than 650,000,000 bits/second, 32-bit packet counters
| > MUST be used and 64-bit octet counters MUST be used. For
| > interfaces that operate at 650,000,000 bits/second or faster,
| > 64-bit packet counters AND 64-bit octet counters MUST be used.
| > </quote>
| 
| It is just easier to have everything 64-bits.

I think the counterpoint is that if it were easy & safe, it would
already be in the kernel.

| > However, this is a MIB spec.  It does not require a Linux
| > (/proc) interface to support 64-bit counters.
| 
| Agreed, however if we are going to change some counters, we should do it for 
| all of them. (Btw, /proc is not the only point where users can get stats.... 
| there is also /sys and something else...I can't remember now...)

Right, I was just saying that the kernel interface doesn't have
to support 64-bit counters in lots of cases.  That can often be
done in userspace.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
