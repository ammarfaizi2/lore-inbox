Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289362AbSAJJzi>; Thu, 10 Jan 2002 04:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSAJJz3>; Thu, 10 Jan 2002 04:55:29 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:6840 "EHLO
	albatross-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S289362AbSAJJzS>; Thu, 10 Jan 2002 04:55:18 -0500
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Thu, 10 Jan 2002 10:55:09 +0100 (MET)
Message-Id: <200201100955.KAA19208@duna207.danubius>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
Subject: [ANNOUNCE] FUSE: Filesystem in Userspace 0.95
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FUSE 0.95 is available (download or CVS) from:

   http://sourceforge.net/projects/avf

What's new in 0.95 compared to 0.9

   - Major performance improvements in both the kernel module and the
     library parts.

   - Small number of bugs fixed.  FUSE has been through some stress
     testing and no problems have turned up yet.

   - Library interface simplified.  A simple 'hello world' filesystem
     can now be implemented in less than 100 lines.

   - Python (by Jeff Epler) and Perl (by Mark Glines) bindings are in
     the works, and will be released some time in the future (now
     available through CVS).

Problems still remaining:

   - Security problems when fuse is used by non-privileged users:

       o permissions on mountpoint can only be checked by kernel
         (patch exists)

       o user can intentionally block the page writeback operation,
         causing a system lockup.  I'm not sure this can be solved in
         a truly secure way.  Ideas?

Introduction for newbies:

  FUSE provides a simple interface for userspace programs to export a
  virtual filesystem to the Linux kernel.  FUSE also aims to provide a
  secure method for non privileged users to create and mount their own
  filesystem implementations.

  Fuse is available for the 2.4 (and later) kernel series.
  Installation is easy and does not need a kernel recompile.
