Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315096AbSENCQt>; Mon, 13 May 2002 22:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSENCQs>; Mon, 13 May 2002 22:16:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:9909 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315096AbSENCQr>;
	Mon, 13 May 2002 22:16:47 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15584.29498.972412.612229@argo.ozlabs.ibm.com>
Date: Tue, 14 May 2002 12:15:22 +1000 (EST)
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 deadlock?
In-Reply-To: <3CDF3C34.5F0EB4EE@zip.com.au>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> It appears that kjournald has submitted a block for writeout
> (via submit_bh() or ll_rw_block()) and the interrupt which
> signifies completion simply hasn't happened.

Ahhh...  I had a "hdparm -m16 -d1 -u1 /dev/hda" command in
/etc/rc.d/rc.sysinit.  If I take that out it doesn't lock up.

So it is an IDE bug not an ext3 bug.  Thanks for the clue.

Paul.
