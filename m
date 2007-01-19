Return-Path: <linux-kernel-owner+w=401wt.eu-S965092AbXASMbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbXASMbI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 07:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbXASMbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 07:31:08 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:33025 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965092AbXASMbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 07:31:06 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 06:56:54 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: can someone explain "inline" once and for all?
Message-ID: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  apologies if this is an inappropriately trivial question but this
has been bugging me for a while.  what is the deal with "inline"?

  first, there appear to be three possible ways of specifying an
inline routine in the kernel source:

  $ grep -r "static inline " .
  $ grep -r "static __inline__ " .
  $ grep -r "static __inline " .

i vaguely recall that this has something to do with a distinction
between C99 inline and gcc inline and trying to avoid a clash between
the two, but i'm not going to put any money on that.  but the
confusion probably explains why so many people insist on creating new
macros to represent inline:

  $ grep -r "#define.*inline" .

is there a simple explanation for how to *properly* define inline
routines in the kernel?  and maybe this can be added to the
CodingStyle guide (he mused, wistfully).

rdau

