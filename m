Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWDULlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWDULlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWDULlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:41:51 -0400
Received: from gherkin.frus.com ([192.158.254.49]:2067 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1751278AbWDULlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:41:50 -0400
Subject: Re: strncpy (maybe others) broken on Alpha
In-Reply-To: <20060421095028.GA8818@bigip.bigip.mine.nu> "from Mathieu Chouquet-Stringer
 at Apr 21, 2006 11:50:28 am"
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Fri, 21 Apr 2006 06:41:49 -0500 (CDT)
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060421114149.24F5EDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Chouquet-Stringer wrote:
> On Fri, Apr 21, 2006 at 11:21:27AM +0200, Mathieu Chouquet-Stringer wrote:
> > The bad news is my test case, compiled with a native gcc version 3.4.4
> > and binutils version 2.16.1 doesn't work as expected.  So maybe it's
> > combination of gcc/binutils?  I'm booting the new kernel just to confirm
> > that 3.4.4 and 2.16.1 do not work.
> 
> A native gcc 3.4.4 and binutils 2.16.1 do not work...  What should we
> try next?

I'll try upgrading from gcc-4.0 to gcc-4.1, and if/when that has no
effect, I'll go looking for a later binutils in Debian's "unstable"
tree (I've already had to go to the "testing" tree to get beyond gcc-3
and binutils-2.15.X).  Report to follow later today.

Item for consideration: what kind of optimization is enabled for your
test case compile vs. what's being used for the kernel build?  That's
another variable we need to sort out.  For what it's worth, I do *not*
have CONFIG_CC_OPTIMIZE_FOR_SIZE enabled: the comment about "watch out
for broken compilers" was enough to scare me off while we're trying to
chase this down.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
