Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278742AbRKSOXv>; Mon, 19 Nov 2001 09:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRKSOXm>; Mon, 19 Nov 2001 09:23:42 -0500
Received: from [195.66.192.167] ([195.66.192.167]:14355 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279084AbRKSOXd>; Mon, 19 Nov 2001 09:23:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 16:22:53 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111916225301.00817@nemo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everytime I do 'chmod -R a+rX dir' and wonder are there
any executables which I don't want to become world executable,
I think "Whatta hell with this x bit meaning 'can browse'
for dirs?! Who was that clever guy who invented that? Grrrr"

Isn't r sufficient? Can we deprecate x for dirs?
I.e. make it a mirror of r: you set r, you see x set,
you clear r, you see x cleared, set/clear x = nop?

Benefits:
chmod -R go-x dir (ensure there is no executables)
chmod -R a+r dir (make tree world readable)
mount -t vfat -o umask=644 /dev/xxx dir
	(I don't want all files to be flagged as executables there)

These commands will do what I want without (sometimes ugly) tricks.
For mount, I can't even see how to do it with current implementation.

What standards will be broken?
Any real loss of functionality apart from compat issues?
--
vda
