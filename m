Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTBXUVf>; Mon, 24 Feb 2003 15:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbTBXUVf>; Mon, 24 Feb 2003 15:21:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28648 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267429AbTBXUUz>; Mon, 24 Feb 2003 15:20:55 -0500
Date: Mon, 24 Feb 2003 12:22:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 405] New: files transfered via SMB come with garbage 
Message-ID: <328180000.1046118125@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=405

           Summary: files transfered via SMB come with garbage
    Kernel Version: 2.5.62-bk7
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86 
Software Environment: 
Samba 2.2.3a-6 from Debian Testing
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_SMB_NLS=y

Problem Description: When transfering a batch of image files from a Win2K
Sp-2  machine to my Linux box running 2.5.62-bk7, the image files
transfered, but  also make two files per image with the file name+some
garbage.  

i.e.:

-rwxr--r--    1 bwindle  bwindle     36329 Mar 12  2002 xp1.gif
-rwxr--r--    1 bwindle  bwindle      8700 Mar 12  2002 xp1.gif:?
Q30lsldxJoudresxAaaqpcawXc:$DATA
-rwxr--r--    1 bwindle  bwindle         0 Mar 12  2002
xp1.gif:{4c8cc155-6c1e- 11d1-8e41-00c04fb9386d}:$DATA

The xp1.gif file is the right size, and works fine. It made copies like
this of  most the the images, but not all of them. There is no messages on
the Linux  console. /home/bwindle is ext3. I'm going to reboot to
2.5.62-bk4 and try it  again.

