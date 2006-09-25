Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWIYKL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWIYKL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWIYKL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:11:28 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:29549 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750932AbWIYKL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:11:27 -0400
Date: Mon, 25 Sep 2006 13:11:24 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: mainline aic94xx firmware woes
Message-ID: <20060925101124.GH6374@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recently merged aic94xx in mainline requires external firmware
support. This, in turn, necessitates an initrd/initramfs environment
that includes firmware support to load the firmware. Will a patch to
optionally include the firmware inline in the kernel and thus not
having to use an initramfs be acceptable?

Also, aic94xx does not compile unless FW_LOADER is set in .config due
to missing 'request_firmware'. What's the right thing to do here -
aic94xx selecting it, depending on it, or FW_LOADER providing empty
request_firmware() in case it's compiled out (the last one violates
the principle of least surprise IMHO).

Cheers,
Muli
