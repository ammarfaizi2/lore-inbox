Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLKCj0>; Sun, 10 Dec 2000 21:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLKCjQ>; Sun, 10 Dec 2000 21:39:16 -0500
Received: from james.kalifornia.com ([208.179.0.2]:41565 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129255AbQLKCjJ>; Sun, 10 Dec 2000 21:39:09 -0500
Message-ID: <3A343728.F4507E5E@linux.com>
Date: Sun, 10 Dec 2000 18:08:40 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: more compile errors, test12-pre8 and reiserfs
Content-Type: multipart/mixed;
 boundary="------------C799080BCCCA0C6D60D96DF0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C799080BCCCA0C6D60D96DF0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o journal.o journal.c
journal.c: In function `reiserfs_journal_commit_thread':
journal.c:1816: invalid operands to binary !=
make[3]: *** [journal.o] Error 1

The portion of code is this:

=>    while(reiserfs_commit_thread_tq) {
        run_task_queue(&reiserfs_commit_thread_tq) ;
      }


This tq_struct change surely missed a whole lot of code.  Granted
reiserfs is an external patch but I've fixed several unrelated parts of
code already.

-d


--------------C799080BCCCA0C6D60D96DF0
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------C799080BCCCA0C6D60D96DF0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
