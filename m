Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318390AbSGYJGO>; Thu, 25 Jul 2002 05:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318394AbSGYJGO>; Thu, 25 Jul 2002 05:06:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:11002 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318390AbSGYJGO>; Thu, 25 Jul 2002 05:06:14 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020725095448.B21541@ucw.cz>
References: <20020724225826.GF25038@holomorphy.com>
	<1027559111.6456.34.camel@irongate.swansea.linux.org.uk> 
	<20020725095448.B21541@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:22:52 +0100
Message-Id: <1027592573.9489.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 08:54, Vojtech Pavlik wrote:
> IMHO the best workaround here would be either to disable PCIBIOS calls
> and revert to conf1 or conf2 in the PCI code if a CMD640 is present, or
> just panic() in the CMD640 code and suggest to the user to use
> "pci=nobios" on the kernel command line. I'd actually prefer the later.

For x86 we can probably do that. It would needlessly break 2.0/2.2/2.4
functionality for the sake of some trivial lock handling. Much better to
fix the problem. I'll take a look at it, when I merge all the other
needed pci config fixes from 2.4 into 2.5, and I guess start putting out
2.5-ac since Linus didnt take all my patches.

[The 2.5 CMD640 code breaks some adaptec stuff which is fixed in the 2.4
 code]

Alan

