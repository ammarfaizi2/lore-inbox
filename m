Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVACBL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVACBL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVACBL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:11:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:32439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261341AbVACBLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:11:23 -0500
Date: Sun, 2 Jan 2005 17:11:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       davidel@xmailserver.org, mh@codeweavers.com, the3dfxdude@gmail.com
Subject: Re: [PATCH] Fix typo in i386 single step changes
In-Reply-To: <20050102234155.GA29453@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0501021709480.2280@ppc970.osdl.org>
References: <m1brc7xv98.fsf@muc.de> <20050102234155.GA29453@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Jan 2005, Daniel Jacobowitz wrote:
> 
> That test is still wrong... the bit is cleared on the previous line. 
> Is it supposed to be testing something else entirely?

Yeah, it's supposed to be removed.

It was old (and clearly broken) cut-and-paste for a condition that can't
happen any more, namely that "ptrace & PT_TRACED" is not set any more. 
That "stale ptrace bit set" condition hasn't been valid for a long time, 
it just never got removed. Oh, well.

		Linus
