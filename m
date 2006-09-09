Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWIIDph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWIIDph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWIIDpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:45:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932121AbWIIDpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:45:36 -0400
Date: Fri, 8 Sep 2006 23:46:38 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [-stable patch] pci_ids.h: add some VIA IDE identifiers
Message-ID: <20060909034638.GA16816@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	Adrian Bunk <bunk@stusta.de>
References: <20060909001925.GB1032@redhat.com> <20060909031020.GA17712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909031020.GA17712@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 08:10:20PM -0700, Greg KH wrote:
 > On Fri, Sep 08, 2006 at 08:19:25PM -0400, Dave Jones wrote:
 > > This never made it into 2.6.17.12
 > > Without it, this happens..
 > > 
 > > drivers/ide/pci/via82cxxx.c:85: error: 'PCI_DEVICE_ID_VIA_8237A' undeclared here (not in a function)
 > 
 > Doh!  Sorry about that, I forgot to do a run with 'make allmodconfig'
 > this time around, and it shows :(
 > 
 > .13 will be out shortly...

Might want to throw this in too, which removes a new warning that appeared in 2.6.17.12
warning about implicit declaration of idr_remove

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/drivers/md/dm.c~	2006-09-08 23:37:08.000000000 -0400
+++ linux-2.6.17.noarch/drivers/md/dm.c	2006-09-08 23:37:16.000000000 -0400
@@ -20,6 +20,7 @@
 #include <linux/idr.h>
 #include <linux/hdreg.h>
 #include <linux/blktrace_api.h>
+#include <linux/idr.h>
 
 static const char *_name = DM_NAME;
 

