Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUAZXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUAZXYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:24:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265356AbUAZXYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:24:15 -0500
Date: Mon, 26 Jan 2004 15:23:56 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <schwidefsky@de.ibm.com>
Cc: zaitcev@redhat.com, laroche@redhat.com, linux-kernel@vger.kernel.org
Subject: Cset 1.1490.4.201 - dasd naming
Message-Id: <20040126152356.0465d26d.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin:

In a recent changeset in Linus' tree, there's your diff which blows up
the dasd naming scheme, with the comment:
 - Change dasd names from "dasdx" to "dasd_<busid>_".

This breaks mkinitrd, nash, and mount by label (not to mention every
zipl.conf out there, because root= aliases to /sys/block/%s).
Would you please explain what exactly you were thinking when you
submitted that patch?

-- Pete

P.S. Cset
http://linux.bkbits.net:8080/linux-2.5/cset@1.1490.4.201?nav=index.html|src/|src/drivers|src/drivers/s390|src/drivers/s390/block|related/drivers/s390/block/dasd_genhd.c
