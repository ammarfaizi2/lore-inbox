Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967367AbWK2OtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967367AbWK2OtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967374AbWK2OtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:49:11 -0500
Received: from smtp.ictp.trieste.it ([140.105.16.52]:14724 "EHLO
	smtp.ictp.trieste.it") by vger.kernel.org with ESMTP
	id S967367AbWK2OtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:49:09 -0500
Message-ID: <53313.62.101.126.236.1164811670.squirrel@webmail2.ictp.trieste.it>
Date: Wed, 29 Nov 2006 15:47:50 +0100 (CET)
Subject: O_DIRECT error, user space programming
From: "Leto Angelo" <aleto@ictp.it>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-ASICTP-MailScanner-Information: Please see http://www.ictp.trieste.it/antispam.html
X-ASICTP-MailScanner: Found to be clean
X-ASICTP-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-5.899, required 5, autolearn=not spam,
	ALL_TRUSTED -3.30, BAYES_00 -2.60)
X-MailScanner-From: aleto@ictp.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got an:
*** glibc detected *** double free or corruption (!prev): 0x84c01000 ***
using O_DIRECT with threads: this error appends if I run several threads
wich are reading several files (opened with O_RDONLY|O_DIRECT) at the same
time.
The error doesn't appends if I open the files whithout O_DIRECT or if I
place a pthread_join after each thread call.
I'm sure that no double free is done.
kernel version: 2.6.17 SMP PREEMPT
glibc version: 2.3.6
filesystem: ext3
g++ used: g++ (GCC) 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)
Does somebody knows the reasons of the error? There are limitation to use
O_DIRECT on a multithread application?
Thanks in advance for any help.
A.

ps. I can provide the source code code (135 lines of C++) if it is useful
to uinderstand better the problem


