Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWFTOkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWFTOkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWFTOkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:40:12 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:58240 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750951AbWFTOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:40:11 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <lkml@rtr.ca>,
       Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 20 Jun 2006 16:39:49 +0200
References: <6pwmi-8mW-1@gated-at.bofh.it> <6px8R-Y7-43@gated-at.bofh.it> <6pxV5-2ci-13@gated-at.bofh.it> <6pz12-3Rg-67@gated-at.bofh.it> <6pzX4-5jE-19@gated-at.bofh.it> <6pA6B-5K8-33@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FshOP-0000pd-No@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-06-19 am 17:52 -0400, ysgrifennodd Mark Lord:

>> Eh?  The vast majority of ISA bus devices have open-collector IRQ lines,
> 
> Not in my experience. In the network work at least very few are, they
> all drive the chip lines all the time. Thats why Don Becker made sure
> such drivers grab the lines at startup. Those which can share IRQ or
> move IRQ grab at open

There are thousands of NE2K-clones, the driver can't know if sharing the IRQ
will be OK for a given card. Is the change for sharing IRQs trivial enough
to allow an if/else based on a load-time module parameter?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
