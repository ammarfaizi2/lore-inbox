Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWAGTLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWAGTLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWAGTLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:11:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17303 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161007AbWAGTKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:10:35 -0500
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
From: Arjan van de Ven <arjan@infradead.org>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <20060107190531.GB8990@kurtwerks.com>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	 <1136544309.2940.25.camel@laptopd505.fenrus.org>
	 <20060107190531.GB8990@kurtwerks.com>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 20:10:31 +0100
Message-Id: <1136661031.2936.34.camel@laptopd505.fenrus.org>
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

On Sat, 2006-01-07 at 14:05 -0500, Kurt Wall wrote:
> On Fri, Jan 06, 2006 at 11:45:09AM +0100, Arjan van de Ven took 0 lines to write:
> > Subject: when CONFIG_CC_OPTIMIZE_FOR_SIZE, allow gcc4 to control inlining
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
> > to decide what to inline and what not - instead of the kernel forcing gcc
> > to inline all the time. This requires several places that require to be 
> > inlined to be marked as such, previous patches in this series do that.
> > This is probably the most flame-worthy patch of the series.
> 
> Hmm. This failed when using -Os while linking vmlinux (gcc 4.0.2):


hmm can you change it to be an __always_inline? it is already that on
x86...


