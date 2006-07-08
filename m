Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWGHJw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWGHJw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWGHJw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:52:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932319AbWGHJw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:52:26 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: joe.korty@ccur.com
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org
In-Reply-To: <20060708094556.GA13254@tsunami.ccur.com>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	 <20060708094556.GA13254@tsunami.ccur.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 11:52:23 +0200
Message-Id: <1152352343.3120.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 05:45 -0400, Joe Korty wrote:
> On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> > That's all theoretical though. Today, gcc's volatile does
> > not follow the C standard on modern hardware. Bummer.
> > It'd be low-performance anyway though.
> 
> But gcc would follow the standard if it emitted a 'lock'
> insn on every volatile reference. 

nope that's not nearly enough for pci MMIO space for example, nor for
any of the weakly ordered architectures.


