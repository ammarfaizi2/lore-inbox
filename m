Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265858AbRF2Km6>; Fri, 29 Jun 2001 06:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbRF2Kms>; Fri, 29 Jun 2001 06:42:48 -0400
Received: from ns.suse.de ([213.95.15.193]:14087 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265855AbRF2Kmo>;
	Fri, 29 Jun 2001 06:42:44 -0400
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT please; Sybase 12.5
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Jun 2001 12:42:37 +0200
In-Reply-To: Dan Kegel's message of "29 Jun 2001 11:38:26 +0200"
Message-ID: <oupwv5v36ua.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@kegel.com> writes:
> 
> And what are the chances Sybase will support that flag any time
> soon?  I just read on news://forums.sybase.com/sybase.public.ase.linux

When Sybase always submits its buffers block aligned (same requirement as
for raw io) you can do it with a simple LD_PRELOAD hack.

I hacked sapdb (which has source available unlike sybase) to do direct IO 
and it seems to not hurt at least.

> It supports raw partitions, which is good; that might satisfy my
> boss (although the administration will be a pain, and I'm not
> sure whether it's really supported by Dell RAID devices).
> I'd prefer O_DIRECT :-(

LVM makes raw partitions much less worse than they used to be. It is 
basically a file system of raw partitions; allowing you to move and resize
them.

-Andi
