Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130960AbRAYPYo>; Thu, 25 Jan 2001 10:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRAYPYe>; Thu, 25 Jan 2001 10:24:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44679 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130960AbRAYPYX>;
	Thu, 25 Jan 2001 10:24:23 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.17652.653140.593056@pizda.ninka.net>
Date: Thu, 25 Jan 2001 07:23:32 -0800 (PST)
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
In-Reply-To: <Pine.LNX.4.30.0101251540001.30299-100000@svea.tellus>
In-Reply-To: <14960.13645.936452.235135@pizda.ninka.net>
	<Pine.LNX.4.30.0101251540001.30299-100000@svea.tellus>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tobias Ringstrom writes:
 > I understand from your comment that you want people to run it on all kinds
 > of hardware, both with and without hw checksumming, but how do you want us
 > to test it?  Is "my computer works as usual with this patch included" what
 > you are looking for, or do you want us to run specific tests or
 > benchmarks?

Basically, make use of the following:

1) TCP applications using normal write/sendmsg to send data
2) TCP applications using sys_sendfile to send data
   (f.e. pftpd or some other server which makes use of Linux's
    sendfile())
3) NFS client side activity

on both cards supporting sg+csum and those which do not.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
