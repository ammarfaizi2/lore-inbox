Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284710AbRLPROK>; Sun, 16 Dec 2001 12:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284727AbRLPROA>; Sun, 16 Dec 2001 12:14:00 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:35693 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S284710AbRLPRNp>; Sun, 16 Dec 2001 12:13:45 -0500
Date: Sun, 16 Dec 2001 19:13:25 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: andrea@suse.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: malloc 1GB on a 2GB ia64 box fails - 17rc1 woes w/ qla1280 and reiserfs
Message-ID: <20011216191325.K12063@niksula.cs.hut.fi>
In-Reply-To: <20011216124328.E21566@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011216124328.E21566@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sun, Dec 16, 2001 at 12:43:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spent a good while trying to reproduce this on 17rc1 (never got as far as
to try -aa), but I never got it booting.

I did get the rejects weeded (-rc1 and ia64-011214 didn't go together
cleanly), although there were some stuff in ptrace.c which I'm really no too
sure of.

It didn't boot, though. qla1280 just hung after "verifying chip" phase.
Strangely, I don't see any changes to qla1280.c in -rc1.

Also, the 2.4.16 kernel I'm using now has gone through a lot of unclean
reboots (usb shutdown used to hang hard until I just disabled the whole
thing.) It had been mostly ok, but after one unclean boot reiserfs got into
state where attempt to mount it crashed it in the next boot. reiserfsck -x
-o -i fixed it, but I think it's still nasty. This was with 2.4.16 (17rc1
never booted thus far).

I hope you can reproduce it on a never kernel (17rc1 or -aa) - it should be
easy, just fill the cache (find / -type f -exec cat {} \; > /dev/null) and
run the test prog.


-- v --

v@iki.fi
