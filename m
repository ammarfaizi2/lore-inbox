Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbULKIgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbULKIgI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 03:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbULKIgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 03:36:08 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:4868 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261863AbULKIgE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 03:36:04 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10rc3+cset == oops (fs).
Date: Sat, 11 Dec 2004 09:36:01 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412102330.02459.pluto@pld-linux.org> <20041210152555.5c579892.akpm@osdl.org> <200412110051.35050.pluto@pld-linux.org>
In-Reply-To: <200412110051.35050.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412110936.02646.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 of December 2004 00:51, Paweł Sikora wrote:
> On Saturday 11 of December 2004 00:25, Andrew Morton wrote:
> > Pawe__ Sikora <pluto@pld-linux.org> wrote:
> > > I've just tried to boot the 2.6.10rc3+cset20041210_0507.
> > >
> > > [handcopy of the ooops]
> > >
> > > dereferencing null pointer
> > > eip at: radix_tree_tag_clear
>
>  407:lib/radix-tree.c ****
>  408:lib/radix-tree.c ****   if (*pathp->slot == NULL)     <=== ooopses
> here 409:lib/radix-tree.c ****    goto out;
>  410:lib/radix-tree.c ****
>

after deep analysis i conclude that this bug is related to the gcc4.
with gcc343 kernel doesn't oops during boot time.
now i'm working on reduced testcase...

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
