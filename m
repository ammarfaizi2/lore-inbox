Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSIIHDr>; Mon, 9 Sep 2002 03:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSIIHDr>; Mon, 9 Sep 2002 03:03:47 -0400
Received: from gc-na5.alcatel.fr ([64.208.49.5]:30083 "EHLO smail2.alcatel.fr")
	by vger.kernel.org with ESMTP id <S316569AbSIIHDq>;
	Mon, 9 Sep 2002 03:03:46 -0400
Message-ID: <3D7C48E6.9DC9E218@sxb.bsf.alcatel.fr>
Date: Mon, 09 Sep 2002 09:08:22 +0200
From: Denis RICHARD <dri@sxb.bsf.alcatel.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Yves LUDWIG <Yves.Ludwig@sxb.bsf.alcatel.fr>,
       Denis RICHARD <Denis.Richard@sxb.bsf.alcatel.fr>
Subject: WEB site for e2compress patch on 2.4 kernel.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A new WEB site  for the e2compress patch on the 2.4 kernel is available
at http://www.alizt.com .

The last version of the patch to download, is 0.4.43 for the 2.4.17 linux kernel.

The fixed bugs are :
 - Deadlock correction between compressing cluster and sync of pages.
 - Management of MAPPED and DIRTY buffer flags.
 - Test of block numbers in compression.
 - Test if page is dirty to allocate buffer when compressing.
 - When decompressing cluster use the size of the cluster and not the size of the file,
     because it can be called from vmtruncate (the size of the file has already changed).
 - Management of working area lock.
 - When (de)compressing file containing holes, the data must be moved and not only the block number.
 - New function ext2_decompress_pages() to allocate blocks for a cluster already read (block decompressed).
     It is now called in ext2_decompress_cluster() and not only in ext2_file_write().

Feel free to contact me if you have some problems.

Good compression.

Bye.

--
-----------------------------\--------------------------\
Denis RICHARD                 \ ALCATEL Business Systems \
mailto:dri@sxb.bsf.alcatel.fr / Tel: +33(0)3 90 67 69 36 /
-----------------------------/--------------------------/



