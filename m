Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315738AbSECW7N>; Fri, 3 May 2002 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315739AbSECW7N>; Fri, 3 May 2002 18:59:13 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:22918 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315738AbSECW7M>; Fri, 3 May 2002 18:59:12 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, bruce.holzrichter@monster.com
Subject: Re: my slab cache broken on sparc64
In-Reply-To: <61DB42B180EAB34E9D28346C11535A781780F2@nocmail101.ma.tmpw.net> <20020503.140507.89264790.davem@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 04 May 2002 00:58:55 +0200
Message-ID: <m38z70kfdc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> It would work if the access was surrounded by:
> 
> 	old_fs = get_fs();
> 	set_fs(KERNEL_DS);
> 	... get_user(kernel_pointer) ...
> 	set_fs (old_fs);
> 
> But it is not.

It was supposed to be. I think we discussed it some time ago, but for 
some reason it was never changed. Will submit a patch in a jiffie.

-Andi (to blame for that code) 

