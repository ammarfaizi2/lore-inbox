Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRKDUp0>; Sun, 4 Nov 2001 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278832AbRKDUpR>; Sun, 4 Nov 2001 15:45:17 -0500
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:25869 "EHLO mail5.kc.rr.com")
	by vger.kernel.org with ESMTP id <S278818AbRKDUpI>;
	Sun, 4 Nov 2001 15:45:08 -0500
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't I strace some processes?
In-Reply-To: <200110121535.QAA30537@mauve.demon.co.uk>
From: Mike Coleman <mkc@mathdogs.com>
Date: 04 Nov 2001 14:45:04 -0600
In-Reply-To: <200110121535.QAA30537@mauve.demon.co.uk>
Message-ID: <877kt6uuy7.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Stirling <root@mauve.demon.co.uk> writes:
> Details: Kernel 2.4.11 strace 4.4 (neither of these seem critical.
> http://www.edonkey2000.com/files/ed2k_linux_gui_0.1alpha.tar.gz Has a binary
> of a p2p client for linux.  It's closed-source, and has a number of issues.
> In attempts to find workarounds for these, I attempted to strace the
> process, and it diddn't quite work.
> 
> It only ever traces syscalls made by the process that originated the
> clone call, never resultant processes, even with -f set.
> Attempring to connect and trace the resultant processes causes strace to
> exit immediately, sometimes STOPing the process that was attempted to
> be traced.

AFAIK, strace 4.4 doesn't know how to trace clone/threads.  I think they're
working on adding the capability.  If you're desperate, you can try
subterfugue, which can trace clone/threads, although it's alpha code and has
some other problems.  (There's a debian package, or see www.subterfugue.org.)

Mike
