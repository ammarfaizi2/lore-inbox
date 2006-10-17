Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWJQPYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWJQPYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWJQPYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:24:24 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:46275 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751085AbWJQPYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:24:23 -0400
Message-ID: <4534F59D.4040505@gmail.com>
Date: Tue, 17 Oct 2006 17:24:13 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: trond.myklebust@fys.uio.no
Subject: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.51.75
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I can't write on mounted nfs filesystem since 2.6.19-rc1 (nfs client):
touch: cannot touch `aaa': Read-only file system

strace says:
open("aaa", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = -1 EROFS 
(Read-only file system)

2.6.18 behaves correctly. Settings are the same, does anybody have any clue?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
