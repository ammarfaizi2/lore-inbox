Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTKPVhe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 16:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTKPVhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 16:37:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:33516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262940AbTKPVhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 16:37:33 -0500
Date: Sun, 16 Nov 2003 13:42:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Message-Id: <20031116134231.763fc5ed.akpm@osdl.org>
In-Reply-To: <3FB7DCF9.5090205@gmx.de>
References: <20031116192643.GB15439@zip.com.au>
	<3FB7DCF9.5090205@gmx.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <prakashpublic@gmx.de> wrote:
>
> CaT wrote:
> 
>  > I just noticed major interactivity problems whilst ogging one of my
> 

"ogging"?

> Going back to mm2 (patched mm2) and everything it fine again.

Two things to try, please:

a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus 
	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch

b) The only significant scheduler change in mm3 was 
	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-fix.patch
	
   So please try -mm3 with the above patch reverted with

	patch -R -p1 < context-switch-accounting-fix.patch


Thanks.
