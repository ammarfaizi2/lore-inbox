Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317461AbSFCTUq>; Mon, 3 Jun 2002 15:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSFCTUp>; Mon, 3 Jun 2002 15:20:45 -0400
Received: from [213.187.195.158] ([213.187.195.158]:10491 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S315429AbSFCTUo>; Mon, 3 Jun 2002 15:20:44 -0400
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
In-Reply-To: <ved6vepylg.fsf@inigo.ingate.se>
	<20020603142424.A29676@redhat.com>
From: Marcus Sundberg <marcus@ingate.com>
Date: 03 Jun 2002 21:20:34 +0200
Message-ID: <vewutgw4n1.fsf@inigo.ingate.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@redhat.com> writes:

> What version of ns83820.c are you using?  Version 0.17 of ns83820.c 
> made significant improvements under load.  Other possibilities include 
> cabling problems (watch the kernel logs for changes in link state).  
> Try to find out where the packets are getting dropped by looking 
> through /proc/net/snmp and other statistics counters in the kernel.

0.17, but some more testing showed that the ns83820 actually works
just fine during this test when using just crossover cables and
running at gigabit speed. The original testing was done using
100Mbit hubs, so my guess would be that the 83820 chips (and/or
driver) doesn't handle collisions too well (which I don't have a
problem with, as afaik GE is always switched).

However the DFE-580TX problems remain regardless of using a hubbed
or switched network.

(As booth eepro100 and tulip-based cards works fine with the hubs
I'm quite certain there's nothing wrong with them.)

//Marcud
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
