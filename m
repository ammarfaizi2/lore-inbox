Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVLJXGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVLJXGT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 18:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVLJXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 18:06:19 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:1746 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932140AbVLJXGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 18:06:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Sun, 11 Dec 2005 00:07:34 +0100
User-Agent: KMail/1.9
Cc: adi@hexapodia.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20051205081935.GI22168@hexapodia.org> <200512060005.04556.rjw@sisk.pl> <20051210142149.f3f8fc02.akpm@osdl.org>
In-Reply-To: <20051210142149.f3f8fc02.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512110007.35346.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 10 December 2005 23:21, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Till now, we have used the simplistic approach
> > based on freeing as much memory as possible before suspend.  Now, we
> > are freeing only as much memory as necessary, which is on the other
> > end of the scale, so to speak.
> 
> You might want to play with
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/broken-out/drop-pagecache.patch.
>  That's a fast-and-easy way of freeing up quite a lot of memory.

Thanks a lot for this hint. :-)

Would that be ok if I made drop_pagecache() nonstatic and called it directly
from swsusp?
