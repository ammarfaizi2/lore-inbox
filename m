Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbVICATL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbVICATL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVICATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:19:11 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:31249 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1161070AbVICATK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:19:10 -0400
Date: Fri, 2 Sep 2005 19:38:19 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Alan Menegotto <macnish@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML x86_86 Multicast Patch
Message-ID: <20050902233819.GA11819@ccure.user-mode-linux.org>
References: <1c699250050902155251c18bb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c699250050902155251c18bb5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 07:52:02PM -0300, Alan Menegotto wrote:
> In mcast_user.c from /usr/src/linux-2.6.13/arch/um/drivers when
> multicast is enabled it cannot pass the "compile kernel" phase. The
> following patch should fix the error. Please correct me if I'm wrong.
> 
> ====================================================
> 
> 
> --- /tmp/mcast_user.c   2005-09-03 19:59:15.000000000 -0300
> +++ mcast_user.c        2005-09-03 19:59:32.000000000 -0300
> @@ -13,7 +13,7 @@
> 
>  #include <errno.h>
>  #include <unistd.h>
> -#include <linux/inet.h>
> +//#include <linux/inet.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/time.h>

Well, it passes my compile kernel phase, otherwise it would have been
fixed already.  But eliminating that include doesn't break anything
(as it can't, considering that inet.h is empty), so this is applied,
thanks.

				Jeff
