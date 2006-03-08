Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWCHFOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWCHFOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 00:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWCHFOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 00:14:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWCHFOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 00:14:36 -0500
Date: Tue, 7 Mar 2006 21:12:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
Message-Id: <20060307211240.4b1bb373.akpm@osdl.org>
In-Reply-To: <20060308.135840.69058042.nemoto@toshiba-tops.co.jp>
References: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
	<20060307180907.GA13577@linux-mips.org>
	<20060308.135840.69058042.nemoto@toshiba-tops.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> >>>>> On Tue, 7 Mar 2006 18:09:07 +0000, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> Below's fix results in exactly the same code size on all
> ralf> compilers and configurations I've tested it.
> 
> ralf> I also have another more elegant fix which as a side effect
> ralf> makes get_unaligned work for arbitrary data types but it that
> ralf> one results in a slight code bloat:
> 
> I tested the patch attached on several MIPS kernel (big/little,
> 32bit/64bit) with gcc 3.4.5.  In most (but not all) case, Ralf's fix
> resulted better than the previous fix.
> 

hmm, well, your earlier patch has had more testing on various platforms,
for what that's worth.  I think for 2.6.16 we should run with that.  If you
want to prepare a patch which implements Ralf's version for post-2.6.16
then that would be good, thanks.

