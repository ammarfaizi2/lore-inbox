Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286147AbRLaBx0>; Sun, 30 Dec 2001 20:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286171AbRLaBxS>; Sun, 30 Dec 2001 20:53:18 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:38923 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S286154AbRLaBxF>; Sun, 30 Dec 2001 20:53:05 -0500
Date: Sun, 30 Dec 2001 20:52:57 -0500
From: Lennert Buytenhek <buytenh@gnu.org>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
Message-ID: <20011230205257.A19891@gnu.org>
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com> <20011230190020.A14157@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230190020.A14157@dea.linux-mips.net>; from ralf@uni-koblenz.de on Sun, Dec 30, 2001 at 07:00:20PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Dec 30, 2001 at 07:00:20PM -0200, Ralf Baechle wrote:

> As user application are trying to use unistd.h and expect errno to get
> set properly unistd.h or at least it's syscallX macros will have to be
> made unusable from userspace or silent breakage of such apps rebuild
> against new headers will occur.

How about conditionalising definition of_syscallX on __KERNEL_SYSCALLS__?
	(http://www.math.leidenuniv.nl/~buytenh/errno_ectomy-1-to-2.diff)

I guess I'll go ask all arch maintainers' permission now..


cheers,
Lennert
