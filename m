Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSJRQ1l>; Fri, 18 Oct 2002 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSJRQ1l>; Fri, 18 Oct 2002 12:27:41 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:30221 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265222AbSJRQ1k>; Fri, 18 Oct 2002 12:27:40 -0400
Date: Fri, 18 Oct 2002 17:33:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Russell Coker <russell@coker.com.au>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018173339.A7481@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <200210181514.g9IFEErG006526@turing-police.cc.vt.edu> <20021018161828.A5523@infradead.org> <200210181830.28354.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210181830.28354.russell@coker.com.au>; from russell@coker.com.au on Fri, Oct 18, 2002 at 06:30:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 06:30:28PM +0200, Russell Coker wrote:
> So how does it harm the mainline kernel to have a system call reserved for LSM 
> and then not allow anything in the mainline kernel that uses it?  Then we can 
> deploy modules using the current LSM design without harming the mainline 
> kernel.


IT adds infrastructure to implement syscalls without peer review.
End then it ends beeing crap like the selinux syscalls.

> The only code that we really want to see in the mainline kernel is the hooks 
> for permission checks.  Personally I would not mind if no security module 
> ever gets included in Linus' source tree.

And exactly these hooks harm.  They are all over the place, have performance
and code size impact and mess up readability.  Why can't you just maintain
an external patch like i.e. mosix folks that nead similar deep changes?

