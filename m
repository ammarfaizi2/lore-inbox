Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTAIDvj>; Wed, 8 Jan 2003 22:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbTAIDvj>; Wed, 8 Jan 2003 22:51:39 -0500
Received: from crack.them.org ([65.125.64.184]:5763 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261530AbTAIDvi>;
	Wed, 8 Jan 2003 22:51:38 -0500
Date: Wed, 8 Jan 2003 23:00:25 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, levon@movementarian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
Message-ID: <20030109040025.GA11596@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	torvalds@transmeta.com, levon@movementarian.org,
	linux-kernel@vger.kernel.org
References: <20030108.150303.130044451.davem@redhat.com> <Pine.LNX.4.44.0301081601300.1096-100000@penguin.transmeta.com> <20030108.160352.78071329.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108.160352.78071329.davem@redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 04:03:52PM -0800, David S. Miller wrote:
>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Wed, 8 Jan 2003 16:02:24 -0800 (PST)
>    
>    Or you can use an /etc/systype file that contains information.
>    
> That sounds fine to me.
> 
> A funny way to initialize this could be by reading System.map
> and seeing how many significant hexidecimal digits are used
> to list the kernel symbol addresses :-)

Don't try it, the perversity of MIPS will break you :)

Just to clarify something that I saw getting lost in this discussion:
Oprofile doesn't need to become built as a 64-bit binary, just
configured to accept 64-bit kernels.  So this doesn't rule out using a
32-bit oprofile (i.e. not needing a 64-bit libc) on a 64-bit kernel. 
It just means that we need to specify it somehow.

John, speaking of MIPS perversity: MIPS64 kernels can come in ELF32
files.  So you may just want to make this a configure-time option.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
