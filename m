Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTBKJfQ>; Tue, 11 Feb 2003 04:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTBKJfQ>; Tue, 11 Feb 2003 04:35:16 -0500
Received: from [66.70.28.20] ([66.70.28.20]:48909 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267339AbTBKJek>; Tue, 11 Feb 2003 04:34:40 -0500
Date: Tue, 11 Feb 2003 10:41:36 +0100
From: DervishD <raul@pleyades.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RESEND][PATCH] mmap.c - do_mmap_pgoff() small correction
Message-ID: <20030211094136.GG42@DervishD>
References: <20021211133246.GE48@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021211133246.GE48@DervishD>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Hi Linus :)
 
     This is a correction for a patch I sent you that you included in
 the 2.5.x tree. The patch I sent you fixed a corner case for the
 mmap() syscall, where the requested size was too big (namely, bigger
 than SIZE_MAX-PAGE_SIZE). Unfortunately, the patch did a wrong
 assumption that is not true in some archs where TASK_SIZE is the full
 address space available, as sparc64. So, the patch didn't fix
 anything on those archs :((
 
     David S. Miller <davem@redhat.com> pointed this and made this new
 patch that fixes the spot. Now it should work in all archs.
 
     If you have any doubt, just tell. The patch is against 2.5.60,
please apply or the corner case won't be fixed on sparc64. Thanks a
lot :)
 
     Raúl
