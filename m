Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282320AbRKXBGy>; Fri, 23 Nov 2001 20:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282318AbRKXBGo>; Fri, 23 Nov 2001 20:06:44 -0500
Received: from relay.planetinternet.be ([194.119.232.24]:6675 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S282316AbRKXBG1>; Fri, 23 Nov 2001 20:06:27 -0500
Date: Sat, 24 Nov 2001 02:06:06 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: asm/fcntl.h problem on libc5 with -ansi
Message-ID: <20011124020606.A9466@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.x kernels generate a problem when you try to include
<fcntl.h> on a libc5 system and use gcc -ansi to compile it.

The problem is that loff_t is not defined in linux/types.h when
__STRICT_ANSI__ is defined.  struct flock64 is using an loff_t.

Either you should place struct flock64 under ifndef
__STRICT_ANSI__ too, or loff_t not.  I used the later here.

Maybe there are others places that have the same problem too?


Kurt

