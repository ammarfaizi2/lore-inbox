Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030618AbWK3Pv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030618AbWK3Pv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbWK3Pve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:51:34 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:23718 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030623AbWK3PvH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:51:07 -0500
Date: Thu, 30 Nov 2006 16:38:39 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-aio <linux-aio@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Bharata B Rao <bharata@in.ibm.com>
Subject: [PATCH -mm 0/5][AIO] - AIO completion signal notification v4
Message-ID: <20061130163839.38689215@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 16:58:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 16:58:14,
	Serialize complete at 30/11/2006 16:58:14
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi

  Here is the latest rework of the AIO completion signal notification patches.

  This set consists in 5 patches:

	1. rework-compat-sys-io-submit: cleanup the sys_io_submit() compat layer,
	   making it more efficient and laying out the base for the following patches

	2. aio-header-fix-includes: fixes the double inclusion of uio.h in aio.h

	3. export-good_sigevent: move good_sigevent into signal.c and make it
	   non-static

	4. aio-notify-sig: the AIO completion signal notification

	5. listio: adds listio support

  Description are in the individual patches.

  Changes from v3:
	All changes following comments from Zach Brown and Christoph Hellwig

	- added justification for the compat_sys_io_submit() cleanup
	- more cleanups in compat_sys_io_submit() to put it in line with
	  sys_io_submit()
	- Changed "Export good_sigevent()" patch name to "Make good_sigevent()
	  non-static" to better describe what it does. 
 	- Reworked good_sigevent() to make it more readable.
	- Simplified the use of the SIGEV_* constants in signal notification
 	- Take a reference on the target task both for the SIGEV_THREAD_ID and
	  SIGEV_SIGNAL cases.

  Changes from v2:
	- rebased to 2.6.19-rc6-mm2
	- reworked the sys_io_submit() compat layer as suggested by Zach Brown
	- fixed saving of a pointer to a task struct in aio-notify-sig as
	  pointed out by Andrew Morton

  Changes from v1:
	- cleanups suggested by Christoph Hellwig, Badari Pulavarty and Zach Brown
	- added lisio patch


  Thanks for your comments, more welcomed, as usual.

  Thanks,

  Sébastien.
