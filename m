Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUDHWrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUDHWrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:47:52 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54422 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262063AbUDHWrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:47:49 -0400
Date: Thu, 08 Apr 2004 15:46:55 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       braam@cs.cmu.edu, Greg Kroah-Hartman <greg@kroah.com>, coda@cs.cmu.edu
Subject: Re: [PATCH 2.6.5] Add sysfs class support to fs/coda/psdev.c
Message-ID: <9260000.1081464415@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1081461739.5880.13.camel@pegasus>
References: <7290000.1081457670@dyn318071bld.beaverton.ibm.com> <7970000.1081458781@dyn318071bld.beaverton.ibm.com> <1081461739.5880.13.camel@pegasus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, April 09, 2004 12:02:19 AM +0200 Marcel Holtmann <marcel@holtmann.org> wrote:

>> +static struct class_simple coda_psdev_class;
> 
> I think coda_psdev_class must be a pointer.
> 
> Regards
> 
> Marcel


Doh! I tested on one system and fixed this there. Then accidentally mailed out the
original. Sorry about that. Here is a patch to fix it:

diff -Nrup -Xdontdiff linux-2.6.5/fs/coda/psdev.c linux-2.6.5p/fs/coda/psdev.c
--- linux-2.6.5/fs/coda/psdev.c	2004-04-08 15:37:06.000000000 -0700
+++ linux-2.6.5p/fs/coda/psdev.c	2004-04-08 15:37:15.000000000 -0700
@@ -62,7 +62,7 @@ unsigned long coda_timeout = 30; /* .. s
 
 
 struct venus_comm coda_comms[MAX_CODADEVS];
-static struct class_simple coda_psdev_class;
+static struct class_simple *coda_psdev_class;
 
 /*
  * Device operations


