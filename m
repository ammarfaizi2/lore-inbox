Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbTDON2K (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTDON2K 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:28:10 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:32700 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S261390AbTDON2J (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 09:28:09 -0400
Date: Tue, 15 Apr 2003 09:39:58 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: compiling 2.4.21-pre7-ac1 with quota support disabled
Message-ID: <20030415133958.GA14403@athame.dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When quota support is disabled, file fs/dquot.c is not compiled;
however, it contains function sync_dquots_dev() which is called twice
from fs/quota.c.  This causes fs.o to fail to link.  #ifdeffing out the
two calls in quota.c seems to do no harm, but I haven't tested it,
other than to boot the resulting kernel and run some file operations.

-- 
| G r e g  L o u i s          | gpg public key: finger     |
|   http://www.bgl.nu/~glouis |   glouis@consultronics.com |
| http://wecanstopspam.org in signatures fights junk email |
