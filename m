Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJZRjA>; Sat, 26 Oct 2002 13:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJZRjA>; Sat, 26 Oct 2002 13:39:00 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44562
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261375AbSJZRi7>; Sat, 26 Oct 2002 13:38:59 -0400
Subject: Re: [PATCH] pre-decoded wchan output
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, riel@conectiva.com.br
In-Reply-To: <20021021230856.GA120@elf.ucw.cz>
References: <1034882043.1072.589.camel@phantasy>
	<20021017205803.A7555@infradead.org> <1034885077.718.595.camel@phantasy> 
	<20021021230856.GA120@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 13:44:40 -0400
Message-Id: <1035654281.1501.7596.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 19:08, Pavel Machek wrote:

> Yes, and force users to update procps for no good reason. And "new"
> procps will still need code to deal with get_wchan themselves... Plus
> you loose information by killing get_wchan() -- two different wait
> points in one function seems very possible to me.

- users of 2.5 need a new procps but only wchan is "broken" and
  only if CONFIG_KALLSYMS is set anyhow

- I did not kill get_wchan, just do not use it in stat - in fact
  I use it in the new wchan approach, too

- its not an issue now because the updated patch (posted 5 days
  after this email you are replying to) keeps wchan.

So you got your way.  Look at the patch posted 22 Oct.  It is now in
2.5-mm.

	Robert Love

