Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267053AbRGYWfU>; Wed, 25 Jul 2001 18:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbRGYWfK>; Wed, 25 Jul 2001 18:35:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:898 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267053AbRGYWfB>;
	Wed, 25 Jul 2001 18:35:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15199.18841.458617.411246@pizda.ninka.net>
Date: Wed, 25 Jul 2001 15:35:05 -0700 (PDT)
To: Leif Sawyer <lsawyer@gci.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc-64 kernel build fails on version.h during 'make oldconfig'
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E1265@berkeley.gci.com>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E1265@berkeley.gci.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Leif Sawyer writes:
 > When 'bootstrapping' a new kernel:
 > 
 > cp ../oldlinux/.config .
 > make oldconfig
 > make dep
 > ...
 > /usr/src/linux/include/linux/udf_fs_sb.h:22: linux/version.h: No such file
 > or directory

Something is terribly wrong with either your system tools or
this ".config" you are using.

If you cannot simply do:

cp arch/sparc64/defconfig .config
make oldconfig; make dep; make clean; make vmlinux; make modules

Then something is truly screwed on your machine.  Watch
for other errors in the make logs if it fails.  I have a
strange feeling that one of the make sub-shells died on
you or something.

Later,
David S. Miller
davem@redhat.com
