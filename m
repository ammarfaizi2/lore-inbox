Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130370AbRAYMRT>; Thu, 25 Jan 2001 07:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRAYMRJ>; Thu, 25 Jan 2001 07:17:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26502 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130370AbRAYMQx>;
	Thu, 25 Jan 2001 07:16:53 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.6408.778595.575341@pizda.ninka.net>
Date: Thu, 25 Jan 2001 04:16:08 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: [UPDATE] Minor zerocopy updates...
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've applied all pending fixes to my tree and thus updated
the 2.4.1-pre10 based zerocopy patch on kernel.org and mirrors:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1p10-2.diff.gz

The new changes are:

1) DecNET updates from Steve Whitehouse
   o endinness bug fix
   o Kill SIOCATEOR handling, better solution exists
2) TCP sendmsg now coalesces pages more optimally.
   From Alexey Kuznetsov.
3) Netfilter fixes from Rusty:
   o Obscure routing error when using masq + fwmark
   o Masquerading table had alignment issue affecting
     non-x86 platforms.

Because #1 and #3 and not netfilter specific, I will be pushing
those changes to Linus.

As stated before, the only showstopping bug report pending on the
zerocopy work are the 3c59x issues.  If people using 3c59x cards can
send success and failure reports here, that would be really
appreciated.  Thanks.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
