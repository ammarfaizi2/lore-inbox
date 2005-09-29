Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVI2Bln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVI2Bln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVI2Bln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:41:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751305AbVI2Bln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:41:43 -0400
Date: Wed, 28 Sep 2005 18:41:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: bbpetkov@yahoo.de, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-Id: <20050928184106.49e9db11.akpm@osdl.org>
In-Reply-To: <20050929011026.GO7992@ftp.linux.org.uk>
References: <20050928083737.GA29498@gollum.tnic>
	<20050928175244.GY7992@ftp.linux.org.uk>
	<20050928222822.GA14949@gollum.tnic>
	<20050929011026.GO7992@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Thu, Sep 29, 2005 at 12:28:22AM +0200, Borislav Petkov wrote:
>  > Andrew told me already today that Jeff[1] had sent a patch fixing all that. To
>  > prevent the leaks he's calling sx_release_io_range(bp) in every check before
>  > exiting sx_probe so this seems correct. A small question though: After calling
>  > sx_request_io_range() in the if-statement on line 499 is it ok to call
>  > sx_request_io_range() for a second time in a row on line 587?  I think in
>  > this case the second call has to go, no?
>  > 
>  > [1]rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 
>  Huh?  I don't see any specialix patches in that repository right now...

http://www.spinics.net/lists/kernel/msg399680.html
