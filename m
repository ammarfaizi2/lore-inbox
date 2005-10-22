Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVJVMSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVJVMSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJVMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 08:18:05 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:18857 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751261AbVJVMSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 08:18:04 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 22 Oct 2005 14:18:03 +0200
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rocketport driver fails if more than four cards are inserted
In-reply-to: <m34q79kc3i.fsf@quimbies.gnus.org>
Message-Id: <20051022121802.349FE1D341E@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Inserting a fifth Rocketport card into a machines gives me the
>backtrace included below.
>
>Looking at the source, it looks like there's two problems: the
>sController array only has four entries, even though CTL_SIZE is
>eight, and some pc104 initialisation is run even though we're not
>running on a pc104 platform.  (Apparently the maximum number of
>controllers on pc104 is four.)
>
>The patch (against 2.6.13.3) included below fixes both these problems.
>The other way to fix the latter problem would be to extend the pc104
>(i.e. ISA) case to allow eight cards, but that seems somewhat less
>likely...
[snip]

They are in process of rewriting the driver (they wrote this to me on Sep 16):

<cite>
We have a driver in beta for 2.6 kernels. Eventually we do plan to update the
main kernel with our changes, but after the driver is more stable and we have
more time to work on it.

Here is a link to the beta if you are interested
ftp://ftp.comtrol.com/contribs/Drivers/RPort/Linux/3.02%20Beta%202.4-2.6/rocketport-linux-3.02.tgz
</cite>

The link is the same, so there is no new version, so I don't know the state of
the rewriting now, we'll see...

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
