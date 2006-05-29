Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWE2EzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWE2EzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 00:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWE2EzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 00:55:07 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:30080 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751176AbWE2EzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 00:55:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
Date: Mon, 29 May 2006 14:52:25 +1000
User-Agent: KMail/1.9.1
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <200605281255.49821.kernel@kolivas.org> <20060527223945.05cd5b5b.rdunlap@xenotime.net> <20060529.013226.108739444.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060529.013226.108739444.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605291452.26423.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 02:32, Atsushi Nemoto wrote:
> On Sat, 27 May 2006 22:39:45 -0700, "Randy.Dunlap" <rdunlap@xenotime.net> 
wrote:
> > > and a missed one:
> > > WARNING: drivers/usb/storage/usb-storage.o - Section mismatch:
> > > reference to .exit.text: from .smp_locks after '' (at offset 0x40)
> >
> > Yep, Jesper posted that one.
> > I also see it in ieee1394.o.
> >
> > So where does the .smp_locks section come from?
> > Is this just a section checker bug/issue?
>
> The .smp_locks section comes from LOCK_PREFIX on x86.  I think the
> warnings was not shown previously just because the modpost did not
> check SHT_REL sections.
>
> Maybe we should fix the modpost to ignore it, but I'm not sure.  Is it
> really safe to ignore?  I'm not a x86 expert ...

A "scary but harmless" comment from someone in the know would be nice.

--
-ck
