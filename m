Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130130AbQK1PGe>; Tue, 28 Nov 2000 10:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130327AbQK1PGY>; Tue, 28 Nov 2000 10:06:24 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:16935 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S130130AbQK1PGK>; Tue, 28 Nov 2000 10:06:10 -0500
Message-ID: <3A23C15E.8A95D729@linux.com>
Date: Tue, 28 Nov 2000 06:29:50 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Blizbor <tb670725@ima.pl>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org, alan@redhat.org
Subject: Re: VFS: brelse message in syslog, its due to ReiserFS or kernelfailure 
 ?
In-Reply-To: <5.0.0.25.0.20001128142121.01da9e20@195.117.13.2>
Content-Type: multipart/mixed;
 boundary="------------7D2A25A72E312CB8CAD6A9DF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7D2A25A72E312CB8CAD6A9DF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I can't say who's fault it is, but I suggest this test12-pre2 patch for clarity

--- fs/buffer.c~        Tue Nov 28 05:11:56 2000
+++ fs/buffer.c Tue Nov 28 06:27:05 2000
@@ -1133,7 +1133,7 @@
                atomic_dec(&buf->b_count);
                return;
        }
-       printk("VFS: brelse: Trying to free free buffer\n");
+       printk("VFS: brelse: Trying to free already free buffer\n");
 }

 /*


Blizbor wrote:

> Machine: P3 500 on ASUS P2B, WD 15GB IDE drive.
> System RH7 with upgraded glibc.
>
> When I'm using 2.2.17 with ReiserFS:
> Nov 26 00:05:05 localhost kernel: Linux version 2.2.17 (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 relea
> se)) #9 Sat Nov 25 17:09:40 CET 2000
>
> I have such messages in syslog and console:
> Nov 26 06:00:49 localhost kernel: VFS: brelse: Trying to free free buffer
> Nov 26 06:07:41 localhost kernel: VFS: brelse: Trying to free free buffer
> Nov 26 06:32:28 localhost kernel: VFS: brelse: Trying to free free buffer

--------------7D2A25A72E312CB8CAD6A9DF
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------7D2A25A72E312CB8CAD6A9DF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
