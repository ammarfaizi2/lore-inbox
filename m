Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUHaUhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUHaUhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUHaUft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:35:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:32470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268987AbUHaUdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:33:22 -0400
Date: Tue, 31 Aug 2004 13:33:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
cc: Tim Fairchild <tim@bcs4me.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: K3b and 2.6.9?
In-Reply-To: <2a4f155d04083113162c2759ea@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0408311332410.2295@ppc970.osdl.org>
References: <200408301047.06780.tim@bcs4me.com> <1093871277.30082.7.camel@localhost.localdomain>
 <200408311151.25854.tim@bcs4me.com> <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
 <2a4f155d04083113162c2759ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, ismail dönmez wrote:
> 
> Checked k3b on CVS and it does this now :
> 
>   int flags = O_NONBLOCK;
>   if( write )
>     flags |= O_RDWR;
>   else
>     flags |= O_RDONLY;
> .....
>   fd = ::open( name, flags );
> 
> which already fixes the issue. Right?

I assume so, assuming that the "write" flag is set correctly. Somebody 
would need to test whether it actually works for them ;)

		Linus
