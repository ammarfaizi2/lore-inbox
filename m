Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263654AbUD2IQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUD2IQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUD2IQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:16:06 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:5553 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S263654AbUD2IQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:16:03 -0400
From: Goran Cengic <cengic@s2.chalmers.se>
Organization: Chalmers University of Technology
To: linux-kernel@vger.kernel.org
Subject: Re: Special place for tird-party modules.
Date: Thu, 29 Apr 2004 10:15:59 +0200
User-Agent: KMail/1.6
References: <200404281814.24991.cengic@s2.chalmers.se> <200404281918.i3SJIPPR005391@turing-police.cc.vt.edu>
In-Reply-To: <200404281918.i3SJIPPR005391@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404291015.59271.cengic@s2.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 21.18, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 28 Apr 2004 18:14:24 +0200, Goran Cengic <cengic@s2.chalmers.se>  
said:
> > I do understand that many developers have several kernel version
> > installed at the same time but is it possible to share between the
> > versions at least the modules that are not developed as the part of the
> > kernel?
> >
> > If I'm missing something cruical please point it out to me.
>
> What you're missing is the reason for modversions to exist - the fact that
> the kernel API *does* change between releases, and even within the same
> source tree (UP vs SMP builds, for instance).  If we supported what you're
> suggesting, then the following *will* happen:
>
> 1) Binary module for 2.6.N is released that uses an API that takes 5
> parameters. 2) 2.6.N+1 comes out, and said API has another parameter added
> (see the recent tweak-fest for elf_map() for an actual example).
> 3) User loads old binary into kernel.
> 4) Kernel OOPs when it dereferences the non-existent 6th parameter that
> wasn't passed by the un-updated binary.

Ok, I get it :) Thank you!

/Goran

----------------------------------
Goran Cengic
mailto:cengic@s2.chalmers.se
----------------------------------
Have a nice day :)
