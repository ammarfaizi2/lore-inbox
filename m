Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWCNAbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWCNAbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWCNAbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:31:48 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:47265 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751461AbWCNAbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:31:47 -0500
Subject: Re: [PATCH] Add "-o bh" option to ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060313095215.GA3700@elf.ucw.cz>
References: <1142016591.21442.38.camel@dyn9047017100.beaverton.ibm.com>
	 <20060313095215.GA3700@elf.ucw.cz>
Content-Type: text/plain; charset=utf-8
Date: Mon, 13 Mar 2006 16:33:20 -0800
Message-Id: <1142296405.21442.54.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 10:52 +0100, Pavel Machek wrote:
> On Pá 10-03-06 10:49:50, Badari Pulavarty wrote:
> > Its not really need for now, but as we try to make "nobh"
> > as default option, it would be nice to have a "-obh" fallback
> > option - if things go wrong.
> 
> Docs patch is missing...
> 
> ...and no, it is not even clear to me what bh vs. nobh does...
> 
> 							Pavel

Hope this helps.

Thanks,
Badari

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc6/Documentation/filesystems/ext3.txt
===================================================================
--- linux-2.6.16-rc6.orig/Documentation/filesystems/ext3.txt	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/Documentation/filesystems/ext3.txt	2006-03-13 16:38:36.000000000 -0800
@@ -113,6 +113,14 @@ noquota
 grpquota
 usrquota
 
+bh		(*)	ext3 associates buffer heads to data pages to
+nobh			(a) cache disk block mapping information
+			(b) link pages into transaction to provide
+			    ordering guarantees.
+			"bh" option forces use of buffer heads.
+			"nobh" option tries to avoid associating buffer
+			heads (supported only for "writeback" mode).
+
 
 Specification
 =============


