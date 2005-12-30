Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVL3IYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVL3IYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVL3IYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:24:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751220AbVL3IYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:24:38 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <20051230081536.GA30503@alpha.home.local>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229231615.GV15993@alpha.home.local>
	 <1135929917.2941.0.camel@laptopd505.fenrus.org>
	 <20051230081536.GA30503@alpha.home.local>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 09:24:32 +0100
Message-Id: <1135931072.2941.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 09:15 +0100, Willy Tarreau wrote:
> 
> 
> I trust your experience on this, but wasn't the lack of testing
> primarily due to the use of a "special" version of the compiler ?
> For instance, if we put a short howto in Documentation/ explaining
> how to build a kgcc toolchain describing what versions to use, there
> are chances that most LKML users will use the exact same version.
> Distro maintainers may want to follow the same version too. Also,
> the fact that the kernel would be designed to work with *that*
> compiler will limit the maintenance trouble you certainly have
> encountered trying to keep the compiler up-to-date with more recent
> kernel patches and updates.

it's not that easy. Simply put: the gcc people release an update every 6
months; distros "jump ahead" the bugfixes on that usually. (think of it
like -stable, where distros would ship patches accepted for -stable but
before -stable got released). Taking an older compiler from gcc.gnu.org
doesn't mean it's bug free. It just means you're not getting bugfixes.


