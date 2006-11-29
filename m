Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967046AbWK2KfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967046AbWK2KfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966993AbWK2Kep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:34:45 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41181 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S966980AbWK2KeL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:34:11 -0500
Date: Wed, 29 Nov 2006 11:24:41 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH -mm 0/5][AIO] - AIO completion signal notification v3
Message-ID: <20061129112441.745351c9@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:18,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:23,
	Serialize complete at 29/11/2006 11:41:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi

  Here is the latest rework of the AIO completion signal notification patches.

  This set consists in 5 patches:

	1. rework-compat-sys-io-submit: rework the sys_io_submit() compat layer,
	   laying out the base for the following patches

	2. aio-header-fix-includes: fixes the double inclusion of uio.h in aio.h

	3. export-good_sigevent: move good_sigevent into signal.c and export it

	4. aio-notify-sig: the AIO completion signal notification

	5. listio: adds listio support

  Description are in the individual patches.


  Changes from v2:
	- rebased to 2.6.19-rc6-mm2
	- reworked the sys_io_submit() compat layer as suggested by Zach Brown
	- fixed saving of a pointer to a task struct in aio-notify-sig as
	  pointed out by Andrew Morton

  Changes from v1:
	- cleanups suggested by Christoph Hellwig, Badari Pulavarty and Zach Brown
	- added lisio patch


  Comments welcomed, as usual.

  Thanks,

  Sébastien.
