Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTJXWR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJXWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:17:28 -0400
Received: from pat.ukc.ac.uk ([129.12.21.15]:61404 "EHLO pat.kent.ac.uk")
	by vger.kernel.org with ESMTP id S262687AbTJXWNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:13:39 -0400
Date: Fri, 24 Oct 2003 22:44:44 +0100
From: Adam Sampson <azz@us-lot.org>
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org
Subject: Odd st_blocks values from smbfs in 2.6.0-test8
Message-ID: <20031024214444.GA23948@cartman.at.fivegeeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Homepage: http://offog.org/
User-Agent: Mutt/1.5.4i
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya.

I've just installed 2.6.0-test8 -- it works beautifully, but I did
notice this odd bit of behaviour from smbfs that I haven't previously
seen. It appears that it's producing an odd value for the st_blocks stat
value:

$ smbmount //server/share mnt
$ cd mnt
$ echo hello >hello
$ ls -l hello
-rwxr--r--    1 nobody   nogroup         6 Oct 24 22:38 hello
$ stat hello
  File: `hello'
  Size: 6               Blocks: 1048576    IO Block: 4096   regular file
Device: fh/15d  Inode: 1641        Links: 1    
Access: (0744/-rwxr--r--)  Uid: ( 9999/  nobody)   Gid: ( 9999/ nogroup)
Access: 2003-10-24 22:38:58.000000000 +0100
Modify: 2003-10-24 22:38:58.000000000 +0100
Change: 2003-10-24 22:38:58.000000000 +0100

$ du -a hello
524288  hello
$ du -ah hello
512M    hello

The server here's Samba 3.0.1pre1, but it does the same with Samba 2 as
well.

Thanks,

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
