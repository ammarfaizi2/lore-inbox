Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbUK3SnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbUK3SnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUK3SmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:42:17 -0500
Received: from ottawa-hs-64-26-171-227.s-ip.magma.ca ([64.26.171.227]:6294
	"HELO edgewater.ca") by vger.kernel.org with SMTP id S262249AbUK3Skw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:40:52 -0500
Message-ID: <000901c4d70c$0ecf1bd0$8500a8c0@WS055>
From: "Yihan Li" <Yihan.Li@Edgewater.CA>
To: <linux-kernel@vger.kernel.org>
Subject: patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3
Date: Tue, 30 Nov 2004 13:40:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help needed!
I am trying to patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3.
The following steps are what I was following:

I download a varnilla version of linux-2.6.9 from www.kernel.org,
Unpack the kernel source:
# cd /usr/src
# tar xvjf linux-2.6.9.tar.bz2
# ln -s linux-2.6.9 linux

Unpack or copy RTAI to  /usr/src/fusion-0.6.4.tar.bz2
# ln -s fusion-0.6.4  rtai

Patch the kernel:
# cd /usr/src/linux
# patch -p1 < ../rtai/arch/i386/patches/adeos-linux-2.6.9-i386-r8.patch
Copy the existing (Fedora) kernel config file to /usr/src/linux
# cp /boot/config-2.6.xxxx /usr/src/linux/.configConfigure the kernel:
# make menuconfig
# make

After 8 mins, I get error messages as following:
drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
make[2]: *** [drivers/scsi/qla2xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

My guess is my configuration is not right, and don't know what to do, really
need a hand ...

I wish to be personally CC'ed the answers/comments in response to my
posting.


