Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbTA2KZ4>; Wed, 29 Jan 2003 05:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTA2KZ4>; Wed, 29 Jan 2003 05:25:56 -0500
Received: from mail.erunway.com ([12.40.51.200]:9231 "EHLO
	mailserver.virtusa.com") by vger.kernel.org with ESMTP
	id <S265689AbTA2KZz>; Wed, 29 Jan 2003 05:25:55 -0500
Date: Wed, 29 Jan 2003 16:35:11 +0600
From: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129103511.GA505@aratnaweera.virtusa.com>
References: <20030129020639.GA10213@aratnaweera.virtusa.com> <20030129053159.GA5999@platan.vc.cvut.cz> <20030129073629.GA26091@aratnaweera.virtusa.com> <20030129080420.GB4950@vana.vc.cvut.cz> <20030129082226.GA668@aratnaweera.virtusa.com> <20030129083752.GD4950@vana.vc.cvut.cz> <20030129091608.GA549@aratnaweera.virtusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129091608.GA549@aratnaweera.virtusa.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 03:16:08PM +0600, Anuradha Ratnaweera wrote:
> 
>   # ./matroxset -m 00001111
>   # ioctl failed: Device or resource busy

Got it working.  Sorry about the wrong use of matroxfb.
Here is my /etc/init.d/movefb:

#!/bin/sh

/sbin/matroxset -f /dev/fb1 -m 0
/sbin/matroxset -f /dev/fb0 -m 1
/sbin/matroxset -f /dev/fb1 -m 2

/sbin/con2fb /dev/fb1 /dev/tty6


Thanks, Petr.

	Anuradha


-- 

Debian GNU/Linux (kernel 2.4.21-pre4)

According to the obituary notices, a mean and unimportant person never dies.

