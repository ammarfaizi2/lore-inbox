Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVIEDYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVIEDYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIEDYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:24:06 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:13362 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932171AbVIEDYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:24:04 -0400
Date: Mon, 05 Sep 2005 12:19:25 +0900 (JST)
Message-Id: <20050905.121925.943973397.hyoshiok@miraclelinux.com>
To: akpm@osdl.org
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: x86-cache-pollution-aware-__copy_from_user_ll.patch added to
 -mm tree
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050904144218.7fe25102.akpm@osdl.org>
References: <200509042017.j84KHekQ032373@shell0.pdx.osdl.net>
	<20050904202333.GA4715@redhat.com>
	<20050904144218.7fe25102.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

> Dave Jones <davej@redhat.com> wrote:
> >
> > On Sun, Sep 04, 2005 at 01:16:00PM -0700, Andrew Morton wrote:
> >   >  unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
> >   >  {
> >   >  	BUG_ON((long) n < 0);
> > 
> >  Ehh? It's unsigned. This will never be true.
> 
> It's cast to long, so it'll trap if we try to copy >=2G.
> 
> It seems a strange thing to check though.   Do we really need it?

I don't know. I've just cut&paste the original __copy_from_user_ll()

Regards,
  Hiro
