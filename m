Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268795AbRG0Jmk>; Fri, 27 Jul 2001 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268800AbRG0JmZ>; Fri, 27 Jul 2001 05:42:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19590 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268795AbRG0Jli>;
	Fri, 27 Jul 2001 05:41:38 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15201.14167.676449.962991@pizda.ninka.net>
Date: Fri, 27 Jul 2001 02:41:43 -0700 (PDT)
To: Leif Sawyer <lsawyer@gci.com>
Cc: Andreas Schwab <schwab@suse.de>, Thorsten Kukuk <kukuk@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: Sparc-64 kernel build fails on version.h during 'make oldconf
	ig'
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E12AA@berkeley.gci.com>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E12AA@berkeley.gci.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Leif Sawyer writes:
 > > |> -dep-files: scripts/mkdep archdep include/linux/version.h
 > > |> +dep-files: include/linux/version.h scripts/mkdep archdep
 > > 
 > > This will still fail with parallel builds.  Better make the 
 > > dependency of archdep on version.h explicit.
 > 
 > Hmm.. didn't think about SMP, as I'm only UP right now.
 > 
 > The enclosed patch then should cover all the architectures
 > for the stock 2.4.7 kernel.

Your patch points out that just making check_asm
depend on include/linux/version.h solves the problem
just fine too.

And this is the change I am making to my tree.  I'd rather
keep the change localized to Sparc{,64} for 2.4.x

Thanks.

Later,
David S. Miller
davem@redhat.com

