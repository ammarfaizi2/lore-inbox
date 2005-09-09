Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVIIQEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVIIQEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVIIQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:04:16 -0400
Received: from smtp.telecable.es ([212.89.0.14]:41206 "EHLO smtp.telecable.es")
	by vger.kernel.org with ESMTP id S932574AbVIIQEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:04:16 -0400
Date: Fri, 9 Sep 2005 18:04:05 +0200
From: Miguel <frankpoole@terra.es>
To: linux-kernel@vger.kernel.org
Subject: PCI bug in 2.6.13
Message-Id: <20050909180405.3e356c2a.frankpoole@terra.es>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.8.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After switching from 2.6.13-rc7 to 2.6.13 I've started to have corrupted
data written on my hard disks, there was appearing blocks of 0x00 bytes
in between the data. I've tracked when this started to happen in the git
patches and I've found that this bug is due to the changes done in the
file drivers/pci/setup-res.c of 2.6.13-rc7-git2 patch. Now I run a 2.6.13
kernel with that file unmodified and everything is ok.
