Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272426AbTHFVNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272387AbTHFVNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:13:51 -0400
Received: from mail.webmaster.com ([216.152.64.131]:24031 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S272426AbTHFVNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:13:50 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Andy Isaacson" <adi@hexapodia.org>,
       "Jesse Pollard" <jesse@cats-chateau.net>
Cc: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: TOE brain dump
Date: Wed, 6 Aug 2003 14:13:47 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEOCEOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030806143956.B15543@hexapodia.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This statement is completely false.  Ethernet switches *do* read the
> packet into memory before starting transmission.

	Some do. Some don't. Some are configurable.

> This must be so,
> because an Ethernet switch does not propagate runts, jabber frames, or
> frames with an incorrect ethernet crc.

	If they use cut-through switching, they do. Some use adaptive switching,
which means they use cut-through switching but change to store and forward
if there are too many runts, jabber frames, bad CRCs, and so on.

	Obviously, you can't always do a cut-through. If the target port is busy,
cut-through is impossible. If the ports are different speeds, cut-through is
impossible. The Intel 510T switch for my home network does adaptive
switching with configurable error thresholds. In fact, it's even smarter
than that, with an intermediate mode that suppresses runts without doing a
full store and forward. See:
http://www.intel.com/support/express/switches/23188.htm

> If the switch starts
> transmission before it's received the last bit, it is provably
> impossible for it to avoid propagating crc-failing-frames; ergo,
> switches must have the entire packet on hand before starting
> transmission.

	Except not all switches always avoid propogating bad frames.

	DS


