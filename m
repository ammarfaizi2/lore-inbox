Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVIQAD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVIQAD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIQAD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:03:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11485
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750749AbVIQAD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:03:56 -0400
Date: Fri, 16 Sep 2005 17:03:49 -0700 (PDT)
Message-Id: <20050916.170349.72543699.davem@davemloft.net>
To: rolandd@cisco.com
Cc: viro@ftp.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] utterly bogus userland API in infinibad
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <52psr8k1qg.fsf@cisco.com>
References: <52fys4lsh9.fsf@cisco.com>
	<20050916203724.GH19626@ftp.linux.org.uk>
	<52psr8k1qg.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Sep 2005 16:54:31 -0700

> I have to confess I'm not familiar with how the kernel implements
> SCM_RIGHTS.  Is it something we could use here?

Yes, you could open up an AF_UNIX socket with userspace
and pass the FDs over via SCM_RIGHTS.

Read the unix(7) man page, section ANCILLARY MESSAGES,
sub-section SCM_RIGHTS, to see how userspace can use
this stuff between processes.
