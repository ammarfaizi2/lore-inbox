Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292382AbSBBUoP>; Sat, 2 Feb 2002 15:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292383AbSBBUnz>; Sat, 2 Feb 2002 15:43:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60357 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S292382AbSBBUnv>;
	Sat, 2 Feb 2002 15:43:51 -0500
Date: Sat, 2 Feb 2002 15:43:48 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIOCDEVICE ?
Message-ID: <20020202154348.A26147@havoc.gtf.org>
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com> <20020131181241.A3524@fafner.intra.cogenit.fr> <m3665iqhqn.fsf@defiant.pm.waw.pl> <20020202154424.A5845@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020202154424.A5845@fafner.intra.cogenit.fr>; from romieu@cogenit.fr on Sat, Feb 02, 2002 at 03:44:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 03:44:24PM +0100, Francois Romieu wrote:
> Your patch doesn't apply against 2.5.3. I did a quick update and noticed the
> patch is the sole user of SIOCDEVICE (with dscc4) and SIOCDEVPRIVATE.

SIOCDEVPRIVATE is verboten in 2.5.x, it doesn't pass through ioctl
translation layers like that which exists on sparc64 and ia64; they are
untyped awful interfaces.

The correction would perhaps define a real command as needed...

	Jeff



