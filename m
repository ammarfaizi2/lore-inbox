Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUAOWq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbUAOWq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:46:28 -0500
Received: from dp.samba.org ([66.70.73.150]:37040 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262731AbUAOWq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:46:27 -0500
Date: Fri, 16 Jan 2004 09:46:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       eike-kernel@sf-tec.de, rth@twiddle.net, torvalds@osdl.org
Subject: Re: [2.6 patch] if ... BUG() -> BUG_ON()
Message-ID: <20040115224605.GB25094@krispykreme>
References: <20040113213230.GY9677@fs.tum.de> <20040115102048.4689664e.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115102048.4689664e.rusty@rustcorp.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You know, I dislike this.
> 
> The right fix is to hack gcc to allow functions (in this case, BUG()) to have
> an "unlikely" attribute, and therefore know that this branch is unlikely.

FYI the ppc32 and ppc64 BUG_ON avoids the branch completely thanks to
some clever code from paulus. Im not however advocating we rip through
the entire kernel and BUG_ON enable it :)

Anton
