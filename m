Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264698AbSJ3PGS>; Wed, 30 Oct 2002 10:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSJ3PGS>; Wed, 30 Oct 2002 10:06:18 -0500
Received: from k100-23.bas1.dbn.dublin.eircom.net ([159.134.100.23]:53259 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S264698AbSJ3PGR>;
	Wed, 30 Oct 2002 10:06:17 -0500
Message-ID: <3DBFF649.9030906@corvil.com>
Date: Wed, 30 Oct 2002 15:10:01 +0000
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
CC: Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org,
       Denis Richard <dri@sxb.bsf.alcatel.fr>
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com> <20021029201110.A29661@work.bitmover.com> <200210300853.09342.pollard@admin.navo.hpc.mil>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> On Tuesday 29 October 2002 10:11 pm, Larry McVoy wrote:
> 
>>>A r/w compressed filesystem would be darned useful too :)
>>
>>mmap(2) is, err, hard.  Not impossible, it means the file system has to
>>support both compressed and uncompressed files, but it's interesting.
> 
> You can also think of it as a step toward a hierarchical filesystem with the
> files:
> 	1. uncompressed (with uncompressed inode)
> 	2. compressed on line (real disk space allocated)
> 	3. compressed nearline (only compressed inode on disk, with a
> 	reference to offline storage)
> 
> Obviously this is only for very large filesystems (we have one FS that
> is currently between 100-200 TB in size when you include the migrated
> storage).

I think it's worth referencing e2compr here also,
which is a patch that provides transparent compression
for ext2 (& ext3?). Denis RICHARD (CC'd) is maintaining
the 2.4 implementation. I've version 0.4.42 (against
2.4.16) mirrored here:
http://www.iol.ie/~padraiga/patches/e2compr-0.4.42-patch-2.4.16.gz

Note I've used it without problems (to access filesystems
created with the kernel 2.2 version) here:
http://cvs.bofh.asn.au/e2compr/

Pádraig.

