Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUFBQvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUFBQvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUFBQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:51:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41114 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262459AbUFBQvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:51:10 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Date: Wed, 2 Jun 2004 11:50:48 -0500
User-Agent: KMail/1.6
Cc: Andreas Dilger <adilger@clusterfs.com>, Alasdair G Kergon <agk@redhat.com>,
       Andrew Morton <akpm@osdl.org>
References: <20040602154129.GO6302@agk.surrey.redhat.com> <20040602161541.GB15785@schnapps.adilger.int>
In-Reply-To: <20040602161541.GB15785@schnapps.adilger.int>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021150.48049.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 11:15 am, Andreas Dilger wrote:
> On Jun 02, 2004  16:41 +0100, Alasdair G Kergon wrote:
> > kcopyd
> >
> > --- diff/drivers/md/kcopyd.c	1969-12-31 18:00:00.000000000 -0600
> > +++ source/drivers/md/kcopyd.c	2004-06-01 19:51:31.000000000 -0500
> > @@ -0,0 +1,667 @@
> > +/*
> > + * Copyright (C) 2002 Sistina Software (UK) Limited.
> > + *
> > + * This file is released under the GPL.
> > + */
>
> It might be nice to have a brief comment here explaining what this is
> and how it is supposed to be used.

How's this?

We're also working on some general documentation which will go in 
Documentation/device-mapper and will include more detailed information about 
the core driver and the other sub-modules. We'll try to submit those patches 
in the near future.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


--- diff/drivers/md/kcopyd.c	2004-06-02 11:44:53.000000000 -0500
+++ source/drivers/md/kcopyd.c	2004-06-02 11:44:33.000000000 -0500
@@ -2,6 +2,10 @@
  * Copyright (C) 2002 Sistina Software (UK) Limited.
  *
  * This file is released under the GPL.
+ *
+ * Kcopyd provides a simple interface for copying an area of one
+ * block-device to one or more other block-devices, with an asynchronous
+ * completion notification.
  */
 
 #include <asm/atomic.h>
--- diff/drivers/md/kcopyd.h	2004-06-02 11:44:53.000000000 -0500
+++ source/drivers/md/kcopyd.h	2004-06-02 11:44:47.000000000 -0500
@@ -2,6 +2,10 @@
  * Copyright (C) 2001 Sistina Software
  *
  * This file is released under the GPL.
+ *
+ * Kcopyd provides a simple interface for copying an area of one
+ * block-device to one or more other block-devices, with an asynchronous
+ * completion notification.
  */
 
 #ifndef DM_KCOPYD_H
