Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUEFJMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUEFJMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUEFJMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:12:21 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:843 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261711AbUEFJMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:12:20 -0400
X-Mailer: Openwave WebEngine, version 2.8.8 (webedge20-101-183-105-20021108)
X-Originating-IP: [194.171.252.100]
From: <h.verhagen@chello.nl>
Reply-To: h.verhagen@chello.nl
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Thu, 6 May 2004 11:12:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20040506091219.MRWJ15342.amsfep13-int.chello.nl@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No wonder the nvidia binary module doesn't work with 4K stacks. I'm wondered that it even works with 8KB stacks.
The module seems extremely stack hungry.

[harm@node-d-8d2e c]$ objdump -d /lib/modules/2.4.26/kernel/drivers/video/nvidia.o | ./checkstack.pl
0xb6ff3 _nv002427rm: sub $0x908,%esp             (almost 4K !)
0x7ff93 _nv003775rm: sub $0x64c,%esp             ( ~1-2K)
0x21fd3 _nv000899rm: sub $0x648,%esp
f53f: 81 ec 94 05 00 00 sub $0x594,%esp
_nv003402rm: sub $0x594,%esp
0x10247 _nv003354rm: sub $0x520,%esp
0x42633 _nv003333rm: sub $0x4a8,%esp
0x100bb _nv003353rm: sub $0x490,%esp
0x842ff _nv004811rm: sub $0x41c,%esp          (1K from here)


Kind regards,
Harm

