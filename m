Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281757AbRKQOtn>; Sat, 17 Nov 2001 09:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281759AbRKQOte>; Sat, 17 Nov 2001 09:49:34 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:26035 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S281757AbRKQOtU>; Sat, 17 Nov 2001 09:49:20 -0500
Subject: Re: Driver callback routine when panic() is called
From: Georg Nikodym <georgn@somanetworks.com>
To: "Pinyowattayakorn, Naris" <np151003@exchange.SanDiegoCA.NCR.COM>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <17427.1005997080@ocs3.intra.ocs.com.au>
In-Reply-To: <17427.1005997080@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 17 Nov 2001 09:49:16 -0500
Message-Id: <1006008556.1923.20.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-11-17 at 06:38, Keith Owens wrote:
> On Fri, 16 Nov 2001 20:30:23 -0500, 
> "Pinyowattayakorn, Naris" <np151003@exchange.SanDiegoCA.NCR.COM> wrote:
> >Is there any call that can be used for a driver to register system crash
> >callback routines. Thus, If panic( ) is called, such a callback can save
> >device-state information to be written into the system crash dump file. 
> 
> notifier_chain_register(&panic_notifier_list, ...)

Pat O'Rourke also posted a patch[1] that exposes this nicely
(panic_notifier_list is currently static in panic.c).

I've been using this on architectures for which I don't yet have kdb.

[1] http://www.uwsg.iu.edu/hypermail/linux/kernel/0106.1/0978.html

