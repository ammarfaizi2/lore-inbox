Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTFCLAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTFCLAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:00:05 -0400
Received: from imsantv23.netvigator.com ([210.87.250.79]:34465 "EHLO
	imsantv23.netvigator.com") by vger.kernel.org with ESMTP
	id S264952AbTFCLAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:00:04 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Morton <akpm@digeo.com>
Subject: NFS io errors on transfer from system running 2.4 to system running 2.5
Date: Tue, 3 Jun 2003 19:12:51 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306031912.53569.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of weird errors:

For the last few months I encounter this:

When doing rsync or cp _from_ system running 2.4 _to_ system running 2.5 
get Input/output error errors with random files.

- 2-5 > 2.4 is OK!
- SRebootting, swapping kernel causes the error on the system running 2.4    
- Fast machine > slow machine or slow machine > fast machine
  is no different
- Both systems run same distribution 
- Encountered since 2.4.20 with about 2.5.64 (my first 2.5 kernel)

Example:

/temp contains a couple of crap files

system mhfl2 is running 2.5.6x to 2.5.70-mm3 mounted on
/mnt/mhfl2.

On system running 2.4.20 or 2.4.21-x:
  while ((1)); do cp -f /temp/* /mnt/mhfl2/temp; done

cp: cannot create regular file `/mnt/mhfl2/temp/blah: Input/output error
cp: writing `/mnt/mhfl2/temp/blah: Input/output error

Errors are random, so the files change every run, sometimes there are no errors,
sometimes thre are 3 errors

Q? Any (in)compatibility reason or should I investigate further?

Regards
Michael Frank 

