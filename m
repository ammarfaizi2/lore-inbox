Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282736AbRLOPix>; Sat, 15 Dec 2001 10:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282747AbRLOPin>; Sat, 15 Dec 2001 10:38:43 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:28032 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S282736AbRLOPig>; Sat, 15 Dec 2001 10:38:36 -0500
Date: Sat, 15 Dec 2001 15:40:29 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: reiserfs-dev@namesys.com
Subject: fsx for Linux showing up reiserfs problem?
Message-ID: <20011215154029.A3954@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	reiserfs-dev@namesys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
 After reading the article at http://www.kerneltrap.com/article.php?sid=415&mode=thread&order=0
on the FreeBSD guys finding a bunch of NFS bugs with a stress tool,
I took a look at fsx and played with it a little under Linux..

The changes to make it work are trivial, and are at
http://www.codemonkey.org.uk/cruft/fsx-linux.c
(non-existant include & expected mmap() behaviour differences)

I've done a few tests on local filesystems, and so far Ext2 & Ext3
seem to be holding up..

Reiserfs however dies very early into the test..

  truncating to largest ever: 0x3f15f
  READ BAD DATA: offset = 0x1d3d4, size = 0x962f
  OFFSET  GOOD    BAD     RANGE
  0x1d3d4 0x177d  0x0000  0x  563
  operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops

Options used were ./fsx -c1234 /mnt/test/testfile
(Although it seems to crash with any -c option)

Looks like an interesting tool, and probably something that should
be added to testsuites like Cerberus.

regards,
Dave.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
