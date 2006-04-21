Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWDUSdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWDUSdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWDUSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:33:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751031AbWDUSdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:33:02 -0400
Date: Fri, 21 Apr 2006 11:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: grievre@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: NFS bug?
Message-Id: <20060421113156.35c626dc.akpm@osdl.org>
In-Reply-To: <1145628470.8150.10.camel@lade.trondhjem.org>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> > I'd be guessing that filldir64() was passed a negative namlen.
> 
>  Why would that trigger a bug in __copy_from_user_ll()? I could see it
>  triggering errors in copy_to_user(), but not copy_from_*...

Ah.  No, I cannot see why getdents wold run copy_from_user().

I wonder why that stack trace didn't come out.  Perhaps running `dmesg -n
7' prior to triggerng the crash will help.  (It shouldn't, but we might
have broken it).

