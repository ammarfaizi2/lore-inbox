Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWDUTez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWDUTez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWDUTez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:34:55 -0400
Received: from pat.uio.no ([129.240.10.6]:51683 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932361AbWDUTey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:34:54 -0400
Subject: Re: NFS bug?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: grievre@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060421113156.35c626dc.akpm@osdl.org>
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
	 <1145551304.8136.5.camel@lade.trondhjem.org>
	 <b3be17f30604200953i652e14a2n908f1a066ffe4e7f@mail.gmail.com>
	 <1145555789.8136.13.camel@lade.trondhjem.org>
	 <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
	 <1145556613.8136.14.camel@lade.trondhjem.org>
	 <b3be17f30604201114n7a50bad9u6f3839a029f571a7@mail.gmail.com>
	 <1145560845.8136.26.camel@lade.trondhjem.org>
	 <20060421005524.15f1c414.akpm@osdl.org>
	 <1145628470.8150.10.camel@lade.trondhjem.org>
	 <20060421113156.35c626dc.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 15:34:47 -0400
Message-Id: <1145648087.8165.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.813, required 12,
	autolearn=disabled, AWL 1.19, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 11:31 -0700, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > > I'd be guessing that filldir64() was passed a negative namlen.
> > 
> >  Why would that trigger a bug in __copy_from_user_ll()? I could see it
> >  triggering errors in copy_to_user(), but not copy_from_*...
> 
> Ah.  No, I cannot see why getdents wold run copy_from_user().
> 
> I wonder why that stack trace didn't come out.  Perhaps running `dmesg -n
> 7' prior to triggerng the crash will help.  (It shouldn't, but we might
> have broken it).
> 

Also, please check that the kernel was compiled with
CONFIG_FRAME_POINTER and CONFIG_KALLSYMS.

Cheers,
  Trond

