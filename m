Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270674AbTHAGCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270676AbTHAGCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:02:12 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:2321 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S270677AbTHAGCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:02:11 -0400
Message-Id: <200308010546.h715kJj24299@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] Inline vfat_strnicmp()
Date: Fri, 1 Aug 2003 08:55:48 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Ren <l.s.r@web.de>, linux-kernel@vger.kernel.org
References: <20030727172150.15f8df7f.l.s.r@web.de> <200307311357.h6VDvEj20416@Port.imtp.ilyichevsk.odessa.ua> <87zniuwx81.fsf@devron.myhome.or.jp>
In-Reply-To: <87zniuwx81.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2003 18:07, OGAWA Hirofumi wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> 
> > Yes, but some future version would.
> > 
> > Since there is no substantial wins in hunting down
> > such statics, and there is some risk of code bloat when
> > big inlined statics get called from more that one callsite,
> > and it will be automatically handled by smarter compiler someday,
> > I think it makes perfect sense to avoid doing this.
> 
> Could you tell me, if compiler does it in future? I'll gladly kill
> that inline.

I can't be 100.00% sure it will happen. I'd say 98.234235% ;)

Andrew Morton kills extra large inlines, and you are creating them :(
That's not ok. Just leave those poor static functions alone
until compiler will do them, all at once.
There are lots of other stuff to do in the kernel source.
--
vda
