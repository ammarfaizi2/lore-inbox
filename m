Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUFKVM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUFKVM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 17:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUFKVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 17:12:56 -0400
Received: from mail.brumma.com ([213.147.174.48]:15057 "EHLO mail.brumma.com")
	by vger.kernel.org with ESMTP id S262388AbUFKVMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 17:12:55 -0400
Message-ID: <50746.10.100.5.81.1086988491.squirrel@mail.brumma.com>
Date: Fri, 11 Jun 2004 23:14:51 +0200 (CEST)
Subject: Typo in fs/smbfs/file.c
From: "Bernhard Wesely" <bernie@weselyb.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently compiled 2.6.6 and got a gcc warning:

  CC      fs/smbfs/file.o
fs/smbfs/file.c: In function `smb_file_sendfile':
fs/smbfs/file.c:274: warning: unknown conversion type character `z' in format
fs/smbfs/file.c:274: warning: too many arguments for format

Well, there seems to be a "z" instead of a "Z". I changed it and the
compile went cleanly. I downloaded the source of 2.6.7-rc3 and the typo
was still there.

The fixed line looks like:

PARANOIA("%s/%s validation failed, error=%Zd\n", DENTRY_PATH(dentry),
status);


Please CC any answers to me directly as I'm not subscribed to this list.

Bye, Bernhard Wesely

