Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270754AbTHSQSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHSQPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:15:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271283AbTHSQNU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:20 -0400
Subject: RE: [patch] 2.4.x ACPI updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Brown, Len" <len.brown@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC79@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC79@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1061299838.30566.38.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 14:30:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 03:04, Brown, Len wrote:
> The ISO_8859_1 acute accent, u with diaeresis, and registered sign, have been in Config.info since Feb 2002.
> 
> Andy's tools seem to have extended them to 16-bit characters during a merge. 
> A "minor gaff"?  Okay, I guess that's fair.  He promises that he
> doesn't know how to type a latin capital A with a circumflex on his 
> keyboard;-).

8859-1 is wrong by all accounts even though the file uses it for
historical reasons. If anything his change is a good one since UTF-8
actually has all the accents for even European names (ñ, ŵ , ï etc) many
of which are missing from 8859-1.

For kernel messages we use 7bit ascii and fixed the 8bit oddments to
keep sysklogd happy, for Configure.help it is down picking something. In
the 2.5 case I'd definitely vote for UTF-8 since the configuration tools
are using libraries that grok UTF-8 properly. For 2.4 we might want to
be more conservative and use 7bit since fixing the tools is a PITA and
its wrong in most of the world to emit 8859-1 arbitarily and its wrong
in the USA to emit UTF-8 arbitarily since lots of US folks still use
8859-*



