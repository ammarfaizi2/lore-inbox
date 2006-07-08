Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWGHJqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWGHJqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWGHJqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:46:38 -0400
Received: from users.ccur.com ([66.10.65.2]:4233 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932304AbWGHJqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:46:37 -0400
Date: Sat, 8 Jul 2006 05:45:56 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708094556.GA13254@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> That's all theoretical though. Today, gcc's volatile does
> not follow the C standard on modern hardware. Bummer.
> It'd be low-performance anyway though.

But gcc would follow the standard if it emitted a 'lock'
insn on every volatile reference.  It should at least
have an option to do that.

Joe
