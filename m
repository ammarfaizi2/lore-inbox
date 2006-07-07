Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWGGLrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWGGLrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWGGLrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:47:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932118AbWGGLrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:47:47 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/8] Fix FRV, ELF-FDPIC and NOMMU stuff [try #4]
Date: Fri, 07 Jul 2006 12:47:38 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patches:

 (1) Fix compilation errors and other problems in the FRV arch and the
     ELF-FDPIC binfmt driver.

 (2) Fix a problem with the NOMMU ramfs filesystem when executing binaries
     stored therein.

 (3) Fix up the ELF-FDPIC coding style and implement a minor change to reduce
     the number of times ksize() is called.

 (4) Declare SEEK_SET, SEEK_CUR and SEEK_END in linux/fs.h.

 (5) Move roundup() to linux/kernel.h from fs/binfmt_elf.c

 (6) Add ELF-FDPIC coredump support.

 (7) Make the FRV arch make use of the asm-offsets stuff.

In [try #2] the following change has been made:

 (*) Inclusions of <linux/config.h> added by the patches have been dropped as
     they're not necessary.

In [try #3]:

 (*) ELF-FDPIC Coding style fixups.

 (*) Minor ELF-FDPIC change to reduce the number of times ksize() is called.

In [try #4]:

 (*) Fix some more FRV compile warnings.

 (*) Move roundup() to linux/kernel.h.

 (*) Declare the SEEK_* constants in linux/fs.h.

 (*) Clean up ELF-FDPIC some more.
