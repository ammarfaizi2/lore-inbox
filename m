Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVCUDET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVCUDET (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVCUDET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:04:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:22946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261510AbVCUDEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:04:16 -0500
Date: Sun, 20 Mar 2005 19:03:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dan Kegel <dank@kegel.com>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: 2.6.11.3 build problem in arch/alpha/kernel/srcons.c with
 gcc-4.0
Message-Id: <20050320190352.65cc1396.akpm@osdl.org>
In-Reply-To: <423E238F.3030805@kegel.com>
References: <423E238F.3030805@kegel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@kegel.com> wrote:
>
> Anyone with an alpha care to suggest a fix for this?
> 
> arch/alpha/kernel/srmcons.c: In function 'srmcons_open':
> arch/alpha/kernel/srmcons.c:196: warning: 'srmconsp' may be used uninitialized in this function
> make[1]: *** [arch/alpha/kernel/srmcons.o] Error 1
> make: *** [arch/alpha/kernel] Error 2
> 
> I get this when building the 2.6.11.3 kernel with a recent gcc-4.0 snapshot.
> 

It's beyond gcc's ability to figure out that the code is OK.  Options would
be to disable -Werror, or to artificially initialise that variable.

