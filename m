Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136360AbRDWDPc>; Sun, 22 Apr 2001 23:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136358AbRDWDPX>; Sun, 22 Apr 2001 23:15:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7575 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136357AbRDWDPQ>;
	Sun, 22 Apr 2001 23:15:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15075.40500.408470.152332@pizda.ninka.net>
Date: Sun, 22 Apr 2001 20:15:00 -0700 (PDT)
To: ebiederman@lnxi.com (Eric W. Biederman)
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix)
In-Reply-To: <m31yqk8oas.fsf@DLT.linuxnetworx.com>
In-Reply-To: <m31yqk8oas.fsf@DLT.linuxnetworx.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric W. Biederman writes:
 > In building a patch for 2.4.3 I also discovered that we are not taking 
 > the mmap_sem around do_brk in the exec paths.

Does that really matter?  Who else can get at the address space?  We
are a singly referenced address space at that point... perhaps ptrace?

Later,
David S. Miller
davem@redhat.com
