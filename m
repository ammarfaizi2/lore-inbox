Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUC2ObQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUC2ObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:31:16 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:29583 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262882AbUC2ObN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:31:13 -0500
Message-ID: <40681A59.2070002@namesys.com>
Date: Mon, 29 Mar 2004 04:45:13 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Miller <mmiller@hick.org>
CC: linux-kernel@vger.kernel.org, demidov <demidov@namesys.com>,
       reiserfs-dev@namesys.com, Nikita Danilov <god@namesys.com>
Subject: Re: [PATCH] 2.6: improved fdmap
References: <Pine.LNX.4.58.0403252228420.20049@jethro.hick.org>
In-Reply-To: <Pine.LNX.4.58.0403252228420.20049@jethro.hick.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is some commonality of concepts between this and reiser4 flows.  I 
thought you might find that of interest.

Hans

Matt Miller wrote:

>+/*
>+ * purpose
>+ *
>+ *    Map process memory ranges to virtual file descriptors.  This can be
>+ *    thought of as being the opposite of mmap, simply, instead of mapping
>+ *    a file's contents to a memory range, fdmap maps a memory range to
>+ *    a virtual file.  This allows one to read, write, seek, and even
>+ *    mmap the virtual file's contents as if it were a real file on disk.
>+ *
>+ * interface
>+ *
>+ *    fdmap exposes a new system call identifier.  The system call takes
>+ *    arguments as the following prototype conveys:
>+ *
>+ *       int fdmap(void *addr, size_t len, int flags);
>+ *
>+ *    ``flags'' can be one of O_RDONLY, O_WRONLY, or O_RDWR.
>+ *
>+ *    syscall number
>+ *
>+ *       alpha, arm, ia32, sh: 274
>+ *       sparc, sparc64: 218
>+ *       ia64: 1259
>+ *       m68k: 236
>+ *       mips: 32b=4268 64b=5227 64be32=6231
>+ *       parisc: 229
>+ *       ppc, ppc64: 256
>+ *       s390: 265
>+ *       v850: 203
>+ *
>+ * based on
>+ *
>+ *    The underlying virtual filesystem code was adapted from sockfs.
>+ *
>+ * Matt Miller
>+ * mmiller@hick.org
>+ */
>  
>


-- 
Hans


