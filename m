Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVCBDoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVCBDoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 22:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVCBDoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 22:44:37 -0500
Received: from smtpout.mac.com ([17.250.248.83]:206 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262144AbVCBDoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 22:44:34 -0500
In-Reply-To: <200503021327.31429.jcook@siliconriver.com.au>
References: <200502281459.31402.jcook@siliconriver.com.au> <200503010202.j2122b80025303@turing-police.cc.vt.edu> <200502282135.35405.dtor_core@ameritech.net> <200503021327.31429.jcook@siliconriver.com.au>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5DFD93E4-8ACD-11D9-858B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Complicated networking problem
Date: Tue, 1 Mar 2005 22:44:23 -0500
To: Jarne Cook <jcook@siliconriver.com.au>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 01, 2005, at 22:27, Jarne Cook wrote:
> Damn
>
> Having to configure the interfaces using bonding was not really the 
> answer I
> was expecting.
>
> I did not think linux would be that rigid.  I figured if poodoze is 
> able to do
> it (seamlessly mind you), surely linux (with some tinkering) would be 
> able to
> do it also.
>
> The goal was to have the networking on the laptop work as perfectly as
> crapdoze does.
>
> Perhaps I should and this topic to my list of software issues that 
> no-one else
> cares about. "man that list is getting big".  maybe one day I'll 
> develop the
> balls to get deep into the code.

Well, what exactly is the desired behavior for you?  If you have two 
network
interfaces to the same local network, the default config will pick a 
random
one (They're both equal-cost unless you tell it otherwise) and send 
ARPs and
everything else through that one interface.  If you take it down, it may
require a minute or so to update the rest of the network to the new 
hardware
address, but eventually they will figure it out.  I suppose if that is 
the
expected config, you could tell the box to send out a gratuitous ARP 
packet
when you reconfigure interfaces, but that's a userspace issue in any 
case.

As far as networking is concerned, a subnet is an atomic networking 
unit.
Everything on it is considered directly and equally attached to 
everything
else, unless informed otherwise via a switch protocol.  Any system that
doesn't follow that rule is broken.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


