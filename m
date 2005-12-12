Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVLLQNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVLLQNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVLLQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:13:08 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23219 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750723AbVLLQNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:13:07 -0500
Subject: Re: 2.6.15-rc5-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4398D967.4020309@ums.usu.ru>
References: <20051204232153.258cd554.akpm@osdl.org>
	 <4398D967.4020309@ums.usu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Dec 2005 16:12:35 +0000
Message-Id: <1134403956.6841.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-09 at 06:09 +0500, Alexander E. Patrakov wrote:
> With the via82cxxx driver, I can get speed around 20 MB/s from /dev/hda. 
> The pata_via driver downgrades this to 7 MB/s because it needlessly 
> drops the disk to MWDMA2 mode.

This is fixed in the ide patches I've been posting and has been fixed
for a long time. The libata core in the base kernel however isn't bright
enough to independantly tune master and slave.

Jeff asked me to finish sorting out and testing some other things with
those changes (notably ata_piix) to ensure that they don't break
existing setups. I've got that mostly done now although it took some
time because both the original ata_piix and the ide/pci/piix driver turn
out to contain bad mistakes.

I hope to be able to feed the relevant stuff to Jeff this week.



