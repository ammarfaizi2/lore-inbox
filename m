Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164193AbWLHAT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164193AbWLHAT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164121AbWLHAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:19:58 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56571 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164193AbWLHAT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:19:58 -0500
X-Originating-Ip: 74.102.209.62
Date: Thu, 7 Dec 2006 19:16:15 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: CodingStyle:  "kzalloc()" versus "kcalloc(1,...)"
Message-ID: <Pine.LNX.4.64.0612071912030.22957@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i just noticed that there are numerous invocations of kcalloc()
where the hard-coded first arg of # elements is "1", which seems like
an inappropriate use of kcalloc().

  the only rationale i can see is that kcalloc() guarantees that the
memory will be set to zero, so i'm guessing that this form of
kcalloc() was used before kzalloc() existed, or was used by folks who
didn't know that kzalloc() existed.

  if a (zero-filled) single struct is being allocated, is it worth
codifying that that allocation should use kzalloc() and not
kcalloc(1,...)?

rday
