Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272924AbTHKULS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272948AbTHKULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:11:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:40861 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272924AbTHKULR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:11:17 -0400
Date: Mon, 11 Aug 2003 13:14:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: ak@suse.de
Subject: [Bug 1083] New: JFS corrupts file systems on 64bit architectures 
Message-ID: <872950000.1060632898@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1083

           Summary: JFS corrupts file systems on 64bit architectures
    Kernel Version: 2.6.0test2
            Status: NEW
          Severity: high
             Owner: shaggy@austin.ibm.com
         Submitter: ak@suse.de


On AMD64 JFS seems to corrupt file systems quickly. I created a JFS
file system, rsync'ed an BKCVS kernel checkout from another box then
did two cvs updates. Result was that several directory inodes in the 
kernel tree were unreadable on the next access (always returned EPERM 
even for a stat). I did a fsck then, which found some bad inodes and 
resulted in a endless lost+found (ls ran out of memory trying to list it)

2.4 JFS still worked. I also got feedback from one user that they are
seeing similar problems on sparc64.


