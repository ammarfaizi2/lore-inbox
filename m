Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVGSVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVGSVwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVGSVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:52:34 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:34230 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261717AbVGSVw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:52:29 -0400
Message-Id: <42DD7644.5040304@khandalf.com>
Date: Tue, 19 Jul 2005 23:53:08 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: how to be (SAFE) a kernel developer ?
References: <5a3ed56505071807357fc419e7@mail.gmail.com>
    <9a87484905071818116f7cb0de@mail.gmail.com>
In-Reply-To: <9a87484905071818116f7cb0de@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: 8926199c10778946ac1ae66d2da59490
X-Transmit-Date: Tuesday, 19 Jul 2005 23:53:18 +0200
X-Message-Uid: 0000b49cec9d0588000000020000000042dd764e000481da00000001000bcc53
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@84-73-132-32.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 32700; Body=1
	Fuz1=1 Fuz2=1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper Juhl wrote: ...

much useful advice, almost all of which I agree with _BUT_

please do NOT debug kernel mods on your 'main-box', where your
filesystems live. unless you like to live dangerously and make
perfect backups you don't mind spending lots of hours restoring,

unless you want to specialise in file systems, but maybe do
want to work on device drivers use a ---

sacrifical system, and, for example NFS mount everything, on
it from your main box, otherwise use a cheap local disk just
for your fs stuff

then when you blow it there is no FS damage and you don't need
to wait for FSCK, or Journal Replay, when your fs works you
can live more dangerously ;-)

You will also need a main system, and serial X-over cable,
if you want to use some of the increasing number of tools,

kdb, kgdb, kprobes .... that assume a 2 box setup

Finally, Linus personally dislikes debuggers, ... 'read the source
Luke' so patches to the mm or mainstream should be grounded an
source code analysis, not it works or xxx has 0x1234 in it.

-- 
mit freundlichen Grüßen, Brian.
