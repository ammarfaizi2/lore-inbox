Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268092AbTBRXaX>; Tue, 18 Feb 2003 18:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbTBRXaX>; Tue, 18 Feb 2003 18:30:23 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59056 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268092AbTBRXaO>; Tue, 18 Feb 2003 18:30:14 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Julian Anastasov <ja@ssi.bg>
Date: Wed, 19 Feb 2003 10:39:22 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15954.50218.879099.360592@notabene.cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sendmsg and IP_PKTINFO
In-Reply-To: message from Julian Anastasov on Tuesday February 18
References: <Pine.LNX.4.44.0302182055450.3668-100000@l>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 18, ja@ssi.bg wrote:
> 
> 	Hello,
> 
> Neil Brown wrote:
> 
> > Note that the in_pktinfo is described as "some information about the
> > incoming packet".  In particular ipi_ifindex is "the unique index of
> > the interface the packets was received on".
> >
> > i.e. it is more about the incoming than the outgoing packet.
> 
> 	Yes, because when set as socket option you can receive
> pktinfo with recvmsg. But IP_PKTINFO can be used also with sendmsg.
> Just forget about interfaces, i.e. use something like this in cmsg:
> 
> .ipi = {
> 	.ipi_ifindex = 0,
> 	.ipi_spec_dst = local_ip,
> },
> 

Certainly IP_PKTINFO can be used with sendmsg.  The doesn't change the
fact that the documentation clearly says that the information is
information about an incoming packet.

Also, th only documentation I can find does not specify that a value
of 0 means "no specific interface is selected".  So while I can see
from the code that what you suggest would work in practice, it would
be nice if this were clearly documented somewhere.

NeilBrown

