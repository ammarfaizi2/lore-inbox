Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbRLaU5W>; Mon, 31 Dec 2001 15:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287651AbRLaU5M>; Mon, 31 Dec 2001 15:57:12 -0500
Received: from codepoet.org ([166.70.14.212]:36626 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287647AbRLaU4v>;
	Mon, 31 Dec 2001 15:56:51 -0500
Date: Mon, 31 Dec 2001 13:56:50 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
Message-ID: <20011231205649.GB4122@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com> <20011230190020.A14157@dea.linux-mips.net> <20011230205257.A19891@gnu.org> <20011231000120.B16384@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231000120.B16384@dea.linux-mips.net>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 31, 2001 at 12:01:20AM -0200, Ralf Baechle wrote:
> On Sun, Dec 30, 2001 at 08:52:57PM -0500, Lennert Buytenhek wrote:
> 
> > > As user application are trying to use unistd.h and expect errno to get
> > > set properly unistd.h or at least it's syscallX macros will have to be
> > > made unusable from userspace or silent breakage of such apps rebuild
> > > against new headers will occur.
> > 
> > How about conditionalising definition of_syscallX on __KERNEL_SYSCALLS__?
> > 	(http://www.math.leidenuniv.nl/~buytenh/errno_ectomy-1-to-2.diff)
> > 
> > I guess I'll go ask all arch maintainers' permission now..
> 
> Be careful, you'll have to fix at least util-linux (doubleplusyuck) and
> e2fsprogs.

You say this as if having util-linux and e2fsprogs etc get fixed
would be a bad thing...  I personally think this would be a very 
good change, and would let the kernel enforce good programming style,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
