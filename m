Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287550AbRLaPng>; Mon, 31 Dec 2001 10:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287546AbRLaPnR>; Mon, 31 Dec 2001 10:43:17 -0500
Received: from oss.sgi.com ([216.32.174.27]:39912 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S287552AbRLaPnL>;
	Mon, 31 Dec 2001 10:43:11 -0500
Date: Mon, 31 Dec 2001 00:01:20 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Lennert Buytenhek <buytenh@gnu.org>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
Message-ID: <20011231000120.B16384@dea.linux-mips.net>
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com> <20011230190020.A14157@dea.linux-mips.net> <20011230205257.A19891@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230205257.A19891@gnu.org>; from buytenh@gnu.org on Sun, Dec 30, 2001 at 08:52:57PM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 08:52:57PM -0500, Lennert Buytenhek wrote:

> > As user application are trying to use unistd.h and expect errno to get
> > set properly unistd.h or at least it's syscallX macros will have to be
> > made unusable from userspace or silent breakage of such apps rebuild
> > against new headers will occur.
> 
> How about conditionalising definition of_syscallX on __KERNEL_SYSCALLS__?
> 	(http://www.math.leidenuniv.nl/~buytenh/errno_ectomy-1-to-2.diff)
> 
> I guess I'll go ask all arch maintainers' permission now..

Be careful, you'll have to fix at least util-linux (doubleplusyuck) and
e2fsprogs.

  Ralf
