Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTJUNxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTJUNxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:53:33 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:54442 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263113AbTJUNxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:53:31 -0400
Date: Tue, 21 Oct 2003 15:52:21 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>
Subject: Re: RH7.3 can't compile 2.6.0-test8
Message-ID: <20031021135221.GA22633@localhost>
References: <20031021131915.GA4436@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031021131915.GA4436@rushmore>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op dinsdag 21 oktober 2003 om 09:19 uur schreef rwhron@earthlink.net het volgende:

> > The Readme for 2.6.0-test6 still said that gcc 2.95 is required
> 
> test8 Changes still says gcc-2.95.3.  I saw the same compile error
> on RedHat 7.2.  I ended up using gcc-3.3.1.  Later I saw this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106651554401143&w=2
> 
> It's supposed to fix test8 compile with gcc-2.96 for RedHat 7.x.

It seems an odd fix though, the variable tty_nr is at most set once
inside the function, and is inaccessible to other functions so why it
should be volatile seems unclear to me. It might solve the compilation
(now that I look again the original error messages mention gcc internal
representation, so the suggestion of binutils at fault seems unwarranted)
but that seems by accident, not by design?

Perhaps if the huge sprintf with 40+ arguments (fs/proc/array.c, line 346)
amongst which several trinary operators, were to be split up into several
parts, might that not solve the problem more elegantly?
-- 
Marco Roeland
