Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVCXLr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVCXLr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVCXLr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:47:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26525 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262446AbVCXLqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:46:07 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.62.0503222223180.2683@dragon.hyggekrogen.localhost> 
References: <Pine.LNX.4.62.0503222223180.2683@dragon.hyggekrogen.localhost> 
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: security/keys/key.c broken with defconfig 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 24 Mar 2005 11:46:04 +0000
Message-ID: <24082.1111664764@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:

> If I just do a 'make defconfig' and then try to build security/keys/ the 
> build breaks.  Doing 'make allyesconfig' fixes it by defining CONFIG_KEYS 
> which makes include/linux/key-ui.h include the full struct key definition.
> 
> I've not attempted to fix this yet, but thought I'd at least report it.
> 
> 
> juhl@dragon:~/download/kernel/linux-2.6.12-rc1-mm1$ make defconfig
> juhl@dragon:~/download/kernel/linux-2.6.12-rc1-mm1$ make security/keys/

Ah. Why would you do that last command at all?

If you look in security/Makefile, you'll see that the security/keys/ directory
is only entered if CONFIG_KEYS is defined; which in your config it isn't.

David
