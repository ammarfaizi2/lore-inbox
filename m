Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUJHUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUJHUpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUJHUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:45:38 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:23654 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264726AbUJHUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:45:34 -0400
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is right for sector_t
Date: Fri, 8 Oct 2004 22:45:39 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
References: <20041008144034.EB891B557@zion.localdomain> <20041008121239.464151bd.akpm@osdl.org> <Pine.LNX.4.60.0410082105351.26699@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0410082105351.26699@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410082245.39119.blaisorblade_personal@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 22:11, Anton Altaparmakov wrote:
> On Fri, 8 Oct 2004, Andrew Morton wrote:
> > blaisorblade_spam@yahoo.it wrote:


> Actually %Ld is completely wrong.  I know in the kernel it makes no
> difference but people see it in the kernel and then go off an use it in
> userspace and it generates junk output on at least some architectures.
Well, gcc does not complain, and the problem is not "kernel is special" or "on 
some arch it's different". It's an alias for "ll" for both gcc and glibc; I 
checked, in fact, the version below of info pages for glibc:

This is Edition 0.10, last updated 2001-07-06, of `The GNU C Library
Reference Manual', for Version 2.3.x of the GNU C Library.
(I guess the "last update" is botched).

> This is because %L means "long double (floating point)" not "long long
> integer" and when you stuff an integer into it it goes wrong (on some
> architectures)... 
I think an all ones, or at least on i386.
> From the printf(3) man page: 
Outdated.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
