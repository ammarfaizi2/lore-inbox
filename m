Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274971AbTHFWhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274979AbTHFWhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:37:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:1201 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274971AbTHFWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:36:59 -0400
Subject: Re: linux-2.6.0-test2-mm4 O_DIRECT
From: Daniel McNeil <daniel@osdl.org>
To: RaTao <ratao@toxyn.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3173D5.8000705@toxyn.org>
References: <3F30CFC1.1090205@toxyn.org>
	 <20030806121759.50a48626.akpm@osdl.org>  <3F3173D5.8000705@toxyn.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060209414.1903.7.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Aug 2003 15:36:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O_DIRECT also works for me on ext3 using regular write and async i/o
using 512-byte i/o.

Is your buffer alignment correct?
O_DIRECT requires a 512-byte aligned buffer.

Daniel
On Wed, 2003-08-06 at 14:32, RaTao wrote:
> Hi!
> 
> I've correct my (don't know how) misspelled subject :)
> 
> Andrew Morton wrote:
> 
> [..snip..]
> > 
> > 
> > It works OK here.
> > 
> > 
> >>- vmstat doesn't show bi/bo for O_DIRECT's disk access.
> > 
> > 
> > It does here.
> > 
> 
> Maybe goofed somewhere. I can't test it again today, I'll do it tomorrow.
> 
> 
> > 
> > I'd be suspecting your test app: is it checking the return value of all
> > syscalls?
> 
> I'll double check.
> Thanks,
> 
> Ratao
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

