Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273028AbTGaOEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273033AbTGaOEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:04:47 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:37883 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S273028AbTGaOEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:04:45 -0400
Date: Thu, 31 Jul 2003 16:04:43 +0200
From: David Weinehall <tao@acc.umu.se>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Ren <l.s.r@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Inline vfat_strnicmp()
Message-ID: <20030731140442.GE16315@khan.acc.umu.se>
References: <20030727172150.15f8df7f.l.s.r@web.de> <87wue4udxl.fsf@devron.myhome.or.jp> <200307311224.h6VCOMj19676@Port.imtp.ilyichevsk.odessa.ua> <87r846yfag.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r846yfag.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 10:52:23PM +0900, OGAWA Hirofumi wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> 
> > On 27 July 2003 19:33, OGAWA Hirofumi wrote:
> > > Ren <l.s.r@web.de> writes:
> > > 
> > > > the function vfat_strnicmp() has just one callsite. Inlining it
> > > > actually shrinks vfat.o slightly.
> > > 
> > > Thanks. I'll submit this patch to Linus.
> > 
> > Just to deinline it in some months?
> > 
> > Come on, automatically inlining static functions with
> > just one callsite is a compiler's job. Don't do it.
> 
> Unfortunately "gcc version 3.2.3 20030415 (Debian prerelease)"
> doesn't, at least.

And how big is the performance loss?  Is it even measurable?
And even if it is, is optimizing this really worth the trouble?


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
