Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136493AbREJNiX>; Thu, 10 May 2001 09:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136505AbREJNiO>; Thu, 10 May 2001 09:38:14 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:12426 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S136493AbREJNiE>; Thu, 10 May 2001 09:38:04 -0400
Message-ID: <3AFA99C5.1920AA2D@austin.ibm.com>
Date: Thu, 10 May 2001 08:38:13 -0500
From: "Andrew M. Theurer" <atheurer@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruce Allan <bruce.allan@us.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        samba-technical@samba.org
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
In-Reply-To: <OF59641CC4.CEBD69DC-ON88256A47.007BCFFD@LocalDomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Allan wrote:
> 
> Andrew Theurer wrote:
> > I do have kernprof ACG and lockmeter for a 4P run.  We saw no
> > significant problems with lockmeter.  csum_partial_copy_generic was the
> > highest % in profile, at 4.34%.  I'll see if we can get some space on
> > http://lse.sourceforge.net to post the test data.
> 
> The Netfinity system that you are using has two different supported GigE
> adapters.  I assume you are using one of these types - Netfinity Gigabit
> Ethernet Adapter (19K4401) and the Netfinity Gigabit Ethernet SX Server
> Adapter (06P3701); using the acenic.c and e1000.c drivers, respectively.
> >From what I understand after initial perusal of the two drivers, the former
> has receive checksumming support on the adapter itself while the latter,
> the one you are using, does not support hardware checksumming (at least, it
> is not enabled by the driver).

Bruce,

According to Intel's driver for Pro/1000, it supports checksum on Rx via
module option "XsunRX=1".  I have not tried this yet because we are
waiting on our Gbps switch hardware.  
> Are you able to re-run your tests with GigE adapters that support
> checksumming on the hardware instead of doing it in the kernel?  If not, I
> will be running similar tests in a very similar configuration (with the
> 19K4401 adapters) in the near future and can share results if you'd like.

Yes, hopefully we will be running the new setup (64 clients, many Gbps
adapters) in about 2-3 weeks.  At that point I'd like to get some
results for 8-way as well.  It would definitely be a good idea to
compare results.

Andrew Theurer
