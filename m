Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272534AbTGaPlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272529AbTGaPkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:40:05 -0400
Received: from mx1.aruba.it ([62.149.128.130]:10412 "HELO mx1.aruba.it")
	by vger.kernel.org with SMTP id S272527AbTGaPjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:39:35 -0400
Date: Thu, 31 Jul 2003 17:37:23 +0200
From: paolo taraboi <paolo.taraboi@aruba.it>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0 test1 and test2
Message-Id: <20030731173723.62865405.paolo.taraboi@aruba.it>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Rating: mx1.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) The tarfile did not include "linux/include/iobuf.h"  (this causes a
problem in drivers/mtd/devices/blkmtd.c) 2) Copying iobuf.h  from 2.4.20
sources generates an error in function brw_kiosvec due to diffs in param
btw ver 2.4.20 and 2.6.0 (err = brw_kiovec(READ, 1, &iobuf,
rawdevice->binding, blocks, rawdevice->sector_size) => solved changing
the 4th param of  brw_kiovec (in 2.4.20 iobuf.h) to type struct pointer
3) At line 1199 of drivers/mtd/devices/blkmtd.c change "module" with
"owner" regards
Paolo
