Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVGKGmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVGKGmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGKGmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:42:33 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:35019 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261323AbVGKGmb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:42:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cZNdPmp9nvZ0yPCv23OiJaidwQ0V0hXdv6a12ZHCtu8c6v6Sl3wx+F58QQNR8D9g1Bjm/ecAnQKKzowaFU44LijF7RnYIPILpxGC5AwzYNF8ICTVaL+p2fhrXeL72h/51wBDVUjDsIx6zC6z5Idwz1Z2pFQZGqRlqxdRhdPXrLU=
Message-ID: <f95c1df1050710234275d52cad@mail.gmail.com>
Date: Sun, 10 Jul 2005 23:42:31 -0700
From: Jon Florence <jonflo@gmail.com>
Reply-To: Jon Florence <jonflo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Swapping broken on 2.6.9? Limit Page Cache growth?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have got a box running  2.6.9-1.667smp (FC3) with 1GB of Physical
memory & 1GB of swap. I run 2 test programs on the box. The first one
mmaps 800M of memory and mlocks it. The second one tries to allocate
500M of memory in 100K chunks and frees it in the end. However, when
the 2nd program runs, my free swap memory as reported by "top" drops
to zero and OOM kicks in killing my first program. This appears to be
incorrect as I had expected the 2nd program to start swapping. If I
run the same 2 programs on similar hardware but with 2.4.20, I have no
problems. The 2nd program swaps as expected. Can anyone plz suggest
what I can do to remedy the situation or is this a known bug?

Also I seem to be having another problem with the page cache. I am
running Samba on a server with similar hardware as above (FC3). As
soon as I get large reads and/or writes, the page cache grows really
huge, causing OOM to kick in again. Is there is a way to limit page
cache growth or force VM to reclaim memory from page cache? I did find
an old patch which seems like it would work but didnt see much follow
up.

 http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-08/5747.html

Thanks in advance for any help!
Jon
