Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271405AbTGQKll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271400AbTGQKll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:41:41 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:41745 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271405AbTGQKjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:39:15 -0400
Date: Thu, 17 Jul 2003 12:54:07 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Michael Kerrisk <mtk-lists@jambit.com>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?)
Message-ID: <20030717125407.C2302@pclin040.win.tue.nl>
References: <008f01c34c38$9be3c120$c100a8c0@wakatipu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <008f01c34c38$9be3c120$c100a8c0@wakatipu>; from mtk-lists@jambit.com on Thu, Jul 17, 2003 at 09:54:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >        O_TRUNC
> >               If  the  file  already exists and is a regular file
> >               and the open mode allows writing (i.e.,  is  O_RDWR
> >               or  O_WRONLY) it will be truncated to length 0.  If
> >               the file is a FIFO or  terminal  device  file,  the
> >               O_TRUNC  flag  is  ignored. Otherwise the effect of
> >               O_TRUNC is unspecified.
> 
> A late addition to this thread, but all of these systems DO truncate with
> 
> O_RDONLY | O_TRUNC:
> 
> Solaris 8
> Tru64 5.1B
> HP-UX 11.22
> FreeBSD 4.7
> 
> Although this flag combination is left unspecified by SUSv3, I don't
> know of an implementation that DOESN'T truncate in these circumstances.

Yes, when we talked about it I checked a few Linux versions, Solaris 5.7, 5.8,
and Irix 6.5 and they all truncate.

So, the standard says "unspecified" but the industry consensus is clearly
"truncate", never mind the O_RDONLY.

Probably the "unspecified" is there for a good reason, so people should be
able to find systems that do not truncate, but there is no reason at all
for Linux to change behaviour.

