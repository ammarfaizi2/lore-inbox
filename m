Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTDTVoH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTDTVoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:44:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9486 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263715AbTDTVoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:44:06 -0400
Date: Sun, 20 Apr 2003 14:56:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: Andries.Brouwer@cwi.nl, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030420.144336.74721439.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0304201454100.1563-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 Apr 2003, David S. Miller wrote:
>    
>    Such an abstract statement nobody can disagree with.
>    Do you have an opinion in the mknod case?
>    
> If you are trying to reach 64-bit dev_t's, why not
> use __u64 as the argument?

That's not correct either.

I will refuse a patch that just takes "dev_t", since I just think that's 
stupid.

The kernel should get major and minor numbers. It's a sad mistake that 
UNIX uses "dev_t" in the first place, and clearly the glibc interface to 
user mode will have to be that historical braindamage. But we should 
realize that the _right_ interface is keeping the <major, minor> tuple 
explicit, and any new system call interfaces should be of that type.

			Linus

