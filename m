Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbSLQWM1>; Tue, 17 Dec 2002 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbSLQWM1>; Tue, 17 Dec 2002 17:12:27 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32262 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S267187AbSLQWM0>;
	Tue, 17 Dec 2002 17:12:26 -0500
Date: Tue, 17 Dec 2002 23:20:11 +0100
From: romieu@fr.zoreil.com
To: Colin Paul Adams <colin@colina.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alcatel speedtouch USB driver and SMP.
Message-ID: <20021217232010.A19613@electric-eye.fr.zoreil.com>
References: <m3n0n7hi52.fsf@colina.demon.co.uk> <20021215075913.GB2180@kroah.com> <m3hedfhd5l.fsf@colina.demon.co.uk> <20021216051300.GB12884@kroah.com> <m3adj6gwus.fsf@colina.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3adj6gwus.fsf@colina.demon.co.uk>; from colin@colina.demon.co.uk on Mon, Dec 16, 2002 at 09:02:35AM +0000
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Paul Adams <colin@colina.demon.co.uk> :
[...]
> So, is anyone using it on SMP?

drivers/usb/misc/speedtouch.c::udsl_atm_ioctl() calls put_user() and
atm ioctls are issued with spinlock held (see net/atm/common.c::atm_ioctl()).

--
Ueimor
