Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135589AbRDSNe6>; Thu, 19 Apr 2001 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135673AbRDSNet>; Thu, 19 Apr 2001 09:34:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135589AbRDSNee>; Thu, 19 Apr 2001 09:34:34 -0400
Subject: Re: Cross-referencing frenzy
To: dalgoda@ix.netcom.com
Date: Thu, 19 Apr 2001 14:36:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010419062318.F21159@thune.mrc-home.com> from "Mike Castle" at Apr 19, 2001 06:23:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qEbo-0007Dj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For example, one symbol that I saw was CONFIG_EXT2_CHECK, which is code
> > that used to be enabled in the kernel, but is currently #ifdef'd out with
> > the above symbol.  When Ted changed this, he wasn't sure whether we would
> 
> How about something besides CONFIG_ then?  Like maybe DEV_CONFIG_ or DEV_.
> 
> The CONFIG_ name space should be reserved for things that can be configured
> via the config mechanism.

If you add one line you can make it part of the CONFIG_ name space. That is
why it uses CONFIG_. CONFIG_ is a valuable debugging tool too. You also can't
reliably deduce a symbol is dead if its only in source because the source code
may be building for 2.0/2.2/2.4 and the symbol may be relevant only in some
cases. It isnt that simple.

Its a valuable list, but it simply isnt going to be possible to do much by
hand validate.

Alan

