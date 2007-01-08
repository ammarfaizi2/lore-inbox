Return-Path: <linux-kernel-owner+w=401wt.eu-S965280AbXAHBA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbXAHBA5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbXAHBA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:00:56 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47059
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965280AbXAHBA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:00:56 -0500
Date: Sun, 07 Jan 2007 17:00:56 -0800 (PST)
Message-Id: <20070107.170056.76564352.davem@davemloft.net>
To: torvalds@osdl.org
Cc: petero2@telia.com, linux-kernel@vger.kernel.org, kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<m37ivyr1v6.fsf@telia.com>
	<Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 7 Jan 2007 14:50:15 -0800 (PST)

> David, there really *is* something screwy in netfilter. 

Sure, but from what I can see this bug appears unrelated to the one in
kernel bugzilla #7781 that we've been discussing the past few days.

First of all, the nf conntrack paths won't be used by normal
users until 2.6.20-rc1 or so.  The bz #7781 report is against
2.6.19 and all those backtraces have IP conntrack in them, not
nf conntrack.

So what are we compiling with here btw, gcc-4.1?

I want to rule the compiler out in this and the bz #7781 case
so that we can look at the code seriously.
