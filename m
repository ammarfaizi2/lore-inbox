Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133076AbREAAoG>; Mon, 30 Apr 2001 20:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135201AbREAAn4>; Mon, 30 Apr 2001 20:43:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133076AbREAAnq>; Mon, 30 Apr 2001 20:43:46 -0400
Subject: Re: Can eject mounted zip disk after suspend/resume (2.4.4)
To: boukanov@fi.uib.no (Igor Bukanov)
Date: Tue, 1 May 2001 01:47:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEE05AE.1090101@fi.uib.no> from "Igor Bukanov" at May 01, 2001 02:39:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uOJr-0000pC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I hit an eject button on internal IDE IOMEGA zip drive after 
> resume/suspend to memory on my Dell Inspiron 7500 notebook, then the 
> disk will be ejected even if it is mounted. This behavior happens ONLY 
> if I suspend my system with the mounted zip. Could I fix this somehow?

Its an Inspiron bios bug - they fail to preserve the locked stat of the zip
drive across a suspend. Its not the worst bug in the world. In theory the
scsi/ide layer could use a PM notifier to check the locked stat is right
and force the drive into the right state. I'd take patches for it but lets
say its not high on my 'urgent problem' list

