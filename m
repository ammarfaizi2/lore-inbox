Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbULGUuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbULGUuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbULGUuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:50:35 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:31900 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261928AbULGUu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:50:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=g7wtBZqdX8PPq8lnzowG/qk5iDiFL05M5HKbyqZagNoWXQpzOMuoC0EtVS1WtHsdejogS1MTbRa6s5lyqkoU42EP2xPrl7nzq4VRFirq8I4CNrA6InkrYNSPDie5e7zwe+h4HLSMPzhMGmffmndmrKqkRdsgsJiEqUH7EKalYqg=
Message-ID: <36066c8b041207125021015edf@mail.gmail.com>
Date: Tue, 7 Dec 2004 21:50:17 +0100
From: omero omero <omero.omero@gmail.com>
Reply-To: omero omero <omero.omero@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: build fails on several systems at SYSCALL arch/i386/kernel/vsyscall-int80.so
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm currently not subscribed to the list, please Cc me directly
in replies (omero dot omero at gmail dot com).

Building a linux-2.6.x on several different systems,
all with up-to-date tools to match indications in Documentation/Changes,
always fails at this stage:

  CC      arch/i386/kernel/sysenter.o
  LDS     arch/i386/kernel/vsyscall.lds
  AS      arch/i386/kernel/vsyscall-int80.o
  SYSCALL arch/i386/kernel/vsyscall-int80.so
/usr/bin/ld: section .text [ffffffffffffe400 -> ffffffffffffe446]
overlaps section .dynstr [ffffffffffffe1d4 -> ffffffffffffea8d]
/usr/bin/ld: section .eh_frame [ffffffffffffe448 -> ffffffffffffe53b]
overlaps section .dynstr [ffffffffffffe1d4 -> ffffffffffffea8d]
/usr/bin/ld: section .dynamic [ffffffffffffe53c -> ffffffffffffe5bb]
overlaps section .dynstr [ffffffffffffe1d4 -> ffffffffffffea8d]
/usr/bin/ld: section .useless [ffffffffffffe5bc -> ffffffffffffe5c7]
overlaps section .dynstr [ffffffffffffe1d4 -> ffffffffffffea8d]
collect2: ld returned 1 exit status
make[1]: *** [arch/i386/kernel/vsyscall-int80.so] Error 1
make: *** [arch/i386/kernel] Error 2

All hosts are ia32, one being a P266-MMX, one a PIII-Katmai, 
and a P4. I've tryied upgrading to binutils-2.15 and gcc-3.4.3,
the error is always exactly the same.

I've searched all around for some hint
about what the problem can be or how to dig 
further, without any success.
Any help is greatly appreciated.

Cheers,
Davide Manzella
