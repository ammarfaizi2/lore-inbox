Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267948AbTAHWhx>; Wed, 8 Jan 2003 17:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267949AbTAHWhw>; Wed, 8 Jan 2003 17:37:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15849 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267948AbTAHWhu>;
	Wed, 8 Jan 2003 17:37:50 -0500
Date: Wed, 08 Jan 2003 14:37:52 -0800 (PST)
Message-Id: <20030108.143752.53085708.davem@redhat.com>
To: torvalds@transmeta.com
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
References: <20030108205220.GB35912@compsoc.man.ac.uk>
	<Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 8 Jan 2003 13:03:14 -0800 (PST)

   On Wed, 8 Jan 2003, John Levon wrote:
   > What other ways ? Dave M reasonably argued it wasn't part of the
   > architecture's ABI, so did not have a place in the headers.
   
   You should certainly see it in "uname -a" output, for example.
   
Doesn't tell you the kernel pointer size.  We fake the uname
output when a process runs as PERS_LINUX_32BIT which is what
we use to trick 'configure' and other build programs in order to
build 32-bit apps properly.

   Compile oprofile for the proper architecture if you do it yourself, and
   complain to the vendor if the vendor is stupid enough to supply a 32-bit 
   oprofile with a 64-bit kernel.
   
   There is _no_ excuse to bloat the kernel for user mistakes.
   
There simply is no fully usable 64-bit userland on some of these
platforms.
