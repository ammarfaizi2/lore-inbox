Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTDSUno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTDSUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:43:44 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:53237 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263466AbTDSUnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:43:41 -0400
Message-ID: <006101c306b6$2a52f480$6b7ba8c0@max>
From: "Max Linux" <max.linux@ntlworld.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel compile and speakup
Date: Sat, 19 Apr 2003 21:56:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As a Linux newbie, I have been trying to compile a new Linux kernel to give
me raid support.

This was easy the first time, but has failed the second time round, for a
reason I cannot understand.

Using the procedure:

bash# make mrproper
bash# make xconfig

< select all the options I want (including raid support) >

bash# make dep
bash# make clean
bash# make bzImage

The make fails, with the following errors:

In file included from console.c:110:
/usr/src/linux-2.4.18-27.7.x/include/linux/speakup.h:186:25: operator '('
has no left operand
make[3]: *** [console.o] Error 1
make[3]: Leaving directory '/usr/src/linux-2.4.18-27.7.x/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory '/usr/src/linux-2.4.18-27.7.x/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory '/usr/src/linux-2.4.18-27.7.x/drivers'
make: *** [_dir_drivers] Error 2

As far as I can see, there is no reason for speakup.h to be included in the
make. However, since it is there, there is no reason for this error to
occur.
NOTE: The left bracket in the quotes is what is reported, although the
character in speakup.h is <.

speakup is specifically not requested in xconfig, as the vga console.

Please tell me what I have done wrong. As I said before, the previous
compilation went fine. Something has since broken.

Thanks in advance.

Max Booker
max.linux@ntlworld.com

