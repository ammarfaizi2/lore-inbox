Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSGEPMY>; Fri, 5 Jul 2002 11:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGEPMY>; Fri, 5 Jul 2002 11:12:24 -0400
Received: from h24-70-122-134.ek.shawcable.net ([24.70.122.134]:8832 "EHLO
	vance.pcsscreston.ca") by vger.kernel.org with ESMTP
	id <S317193AbSGEPMX>; Fri, 5 Jul 2002 11:12:23 -0400
Subject: Re: prevent breaking a chroot() jail?
From: Vance Lankhaar <vance@pcsscreston.ca>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1025877004.11004.59.camel@zaphod>
References: <1025877004.11004.59.camel@zaphod>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jul 2002 08:17:52 -0700
Message-Id: <1025882272.929.2.camel@vance.pcsscreston.ca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at the GR Security patch. It has a whole bunch of chroot
restrictions, and might just do exactly what you want.
http://www.grsecurity.net

Vance

On Fri, 2002-07-05 at 06:50, Shaya Potter wrote:
> I'm trying to develop a way to ensure that one can't break out of a
> chroot() jail, even as root.  I'm willing to change the way the syscalls
> work (most likely only for a subset of processes, i.e. processes that
> are run in the jail end up getting a marker which is passed down to all
> their children that causes the syscalls to behave differently).
> 
> What should I be aware of?  I figure devices (no need to run mknod in
> this jail) and chroot (as per man page), is there any other way of
> breaking the chroot jail (at a syscall level or otherwise)?
> 
> or is this 100% impossible?
> 
> thanks,
> 
> shaya

-- 
------------------------------------------------------------
 Vance Lankhaar                        vance@pcsscreston.ca
 PCSS Yearbook                      yearbook@pcsscreston.ca
 PCSS Computers                    sysadmins@pcsscreston.ca
 http://www.crestonbc.com/pcss/   http://www.pcsscreston.ca
------------------------------------------------------------
