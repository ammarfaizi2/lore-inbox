Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVCOELw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVCOELw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVCOELw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:11:52 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:45251 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261522AbVCOELu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:11:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <16950.24703.380937.658011@wombat.chubb.wattle.id.au>
Date: Tue, 15 Mar 2005 15:11:43 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e47339105031419501ccd650c@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<9e473391050312075548fb0f29@mail.gmail.com>
	<16948.56475.116221.135256@wombat.chubb.wattle.id.au>
	<9e47339105031317193c28cbcf@mail.gmail.com>
	<16948.60419.257853.470644@wombat.chubb.wattle.id.au>
	<9e47339105031419195bae4e11@mail.gmail.com>
	<16950.23262.895279.635262@wombat.chubb.wattle.id.au>
	<9e47339105031419501ccd650c@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Jon> On Tue, 15 Mar 2005 14:47:42 +1100, Peter Chubb
Jon> <peterc@gelato.unsw.edu.au> wrote:
>> What I really want to do is deprivilege the driver code as much as
>> possible.  Whatever a driver does, the rest of the system should
>> keep going.  That way malicious or buggy drivers can only affect
>> the processes that are trying to use the device they manage.
>> Moreover, it should be possible to kill -9 a driver, then restart
>> it, without the rest of the system noticing more than a hiccup.  To
>> do this, step one is to run the driver in user space, so that it's
>> subject to the same resource management control as any other
>> process.  Step two, which is a lot harder, is to connect the driver
>> back into the kernel so that it can be shared.  Tun/Tap can be used
>> for network devices, but it's really too slow -- you need zero-copy
>> and shared notification.

Jon> Have you considered running the drivers in a domain under Xen?

See the paper presented by Karlsruhr at OSDI:

    Joshua LeVasseur, Volkmar Uhlig, Jan Stoess, and Stefan Götz:
    Unmodified Device Driver Reuse and Improved System Dependability via
    Virtual Machines.  OSDI '04.

They're using L4, rather than Xen as the paravirtualisation layer.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
