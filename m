Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTKQCRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 21:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTKQCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 21:17:43 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:63725 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263131AbTKQCRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 21:17:42 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: Gawain Lynch <gawain@freda.homelinux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org, CaT <cat@zip.com.au>
In-Reply-To: <20031116134231.763fc5ed.akpm@osdl.org>
References: <20031116192643.GB15439@zip.com.au> <3FB7DCF9.5090205@gmx.de>
	 <20031116134231.763fc5ed.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1069035604.1916.3.camel@frodo.felicity.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Nov 2003 13:20:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 08:42, Andrew Morton wrote:
> Two things to try, please:
> 
> a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch
> 
> b) The only significant scheduler change in mm3 was 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-fix.patch
> 	
>    So please try -mm3 with the above patch reverted with
> 
> 	patch -R -p1 < context-switch-accounting-fix.patch
> 

Hi Andrew,

This is also easily reproducible here with just a kernel compile.

I have tried both a) and b) with b) not changing anything, but a) seems
to work...  Anything more to try?

Gawain

