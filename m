Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUELV4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUELV4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUELVz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:55:56 -0400
Received: from ns.suse.de ([195.135.220.2]:37083 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261920AbUELVzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:55:48 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <20040512020700.6f6aa61f.akpm@osdl.org>
	<20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
	<20040512200305.GA16078@elte.hu>
	<Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
	<20040512213913.GA16658@fieldses.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Where's th' DAFFY DUCK EXHIBIT??
Date: Wed, 12 May 2004 23:55:18 +0200
In-Reply-To: <20040512213913.GA16658@fieldses.org> (J. Bruce Fields's
 message of "Wed, 12 May 2004 17:39:13 -0400")
Message-ID: <jevfj1nwe1.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:

> If gcc really optimizes that to just the identity function, then surely
> that's a gcc bug?  Multiplication is left-associative, so i * 1000 /
> 1000 = (i * 1000) / 1000, but (i * 1000) should be zero for any i
> divisible by i^(sizeof(int) - 12).

Signed integer overflow is undefined in C, so the compiler is allowed to
assume it does not happen.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
