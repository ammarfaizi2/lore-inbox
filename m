Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310488AbSCCAe2>; Sat, 2 Mar 2002 19:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310489AbSCCAeS>; Sat, 2 Mar 2002 19:34:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16397 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S310488AbSCCAeH>; Sat, 2 Mar 2002 19:34:07 -0500
Date: Sun, 3 Mar 2002 00:33:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: erich@uruk.org
Cc: Julian Anastasov <ja@ssi.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: Network Security hole (was -> Re: arp bug )
Message-ID: <20020303003351.B6120@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0203030035030.9147-100000@u.domain.uli> <E16hJki-0000rY-00@trillium-hollow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16hJki-0000rY-00@trillium-hollow.org>; from erich@uruk.org on Sat, Mar 02, 2002 at 04:21:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 04:21:24PM -0800, erich@uruk.org wrote:
> The fact that the routing layer and application layers of Linux's
> TCP/IP stack are one and the same is a difficulty here which the
> IP firewalling code in Linux does not fix.  I.e. if I wanted to
> have routing as well, but not accept any packets internally *not*
> destined for my interface, I'm not sure how to specify it without
> something like TCP wrappers, as sleazy as they can be, and they
> don't offer this kind of capability in general as is.

Linux 2.4 netfilter:

Incoming                                                 Outgoing
interface                                                interface
  ----+------------------- FORWARD -----------------+------->
      |                                             ^
      v                                             |
    INPUT -------------> Application -----------> OUTPUT

The names in capitals are the names of the tables.  You can control
packets that the local machine sees completely independently of what
gets routed through the machine with a kernel supporting iptables
by adding the appropriate rules to the input and forward tables.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

