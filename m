Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273027AbTGaNzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273028AbTGaNzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:55:37 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:52228 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S273027AbTGaNzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:55:36 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Ren <l.s.r@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Inline vfat_strnicmp()
References: <20030727172150.15f8df7f.l.s.r@web.de>
	<87wue4udxl.fsf@devron.myhome.or.jp>
	<200307311224.h6VCOMj19676@Port.imtp.ilyichevsk.odessa.ua>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 31 Jul 2003 22:52:23 +0900
In-Reply-To: <200307311224.h6VCOMj19676@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <87r846yfag.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> On 27 July 2003 19:33, OGAWA Hirofumi wrote:
> > Ren <l.s.r@web.de> writes:
> > 
> > > the function vfat_strnicmp() has just one callsite. Inlining it
> > > actually shrinks vfat.o slightly.
> > 
> > Thanks. I'll submit this patch to Linus.
> 
> Just to deinline it in some months?
> 
> Come on, automatically inlining static functions with
> just one callsite is a compiler's job. Don't do it.

Unfortunately "gcc version 3.2.3 20030415 (Debian prerelease)"
doesn't, at least.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
