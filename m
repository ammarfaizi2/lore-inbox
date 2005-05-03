Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVECKkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVECKkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 06:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVECKkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 06:40:42 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:43431 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261445AbVECKfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 06:35:08 -0400
Message-ID: <42775588.95EB8ECF@tv-sign.ru>
Date: Tue, 03 May 2005 14:42:16 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, jk@blackdown.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
		<87wtr8rdvu.fsf@blackdown.de>
		<87u0m7aogx.fsf@blackdown.de>
		<1113607416.5462.212.camel@gaston>
		<877jj1aj99.fsf@blackdown.de>
		<20050423170152.6b308c74.akpm@osdl.org>
		<87fyxhj5p1.fsf@blackdown.de>
		<1114308928.5443.13.camel@gaston>
		<426B6C84.E8D41D57@tv-sign.ru> <20050502232925.752ad1d8.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > ...
> > Before this timer patch del_timer(pending_timer) worked as
> > a memory barrier for the caller, now it does not.
> >
> 
> I wonder if we should still do this?  It would seem to be a safer approach.
> 
> (This barrier stuff continues to give me the creeps.  Imagine being
> dependent upon accidental barriers in the add/del/mod_timer code.  Ugh).

I can't judge. But if we added barriers now, it would be
very hard to remove them later. And I think it's not good
to have these barriers "just in case".

Oleg.
