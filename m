Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUIFSFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUIFSFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbUIFSFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:05:37 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19106 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268381AbUIFSFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:05:19 -0400
Subject: Re: x86 - Realmode BIOS and Code calling module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jozef Vesely <vesely@gjh.sk>
Cc: Jakub Vana <gugux@centrum.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409061703510.31771-100000@eloth.gjh.sk>
References: <Pine.LNX.4.44.0409061703510.31771-100000@eloth.gjh.sk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094490175.4309.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Sep 2004 18:03:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-06 at 16:27, Jozef Vesely wrote:
> In-kernel BIOS calls are useful:
> I (and many others) have experienced problems with resuming from ACPI S3
> state. Some graphic cards need to have their state saved before suspend
> and restored after resume, otherwise the screen stays blank. VESA BIOS
> call 0x4f04, does exactly that.

As I understand it VESA 0x4F04 is for saving/restoring mode state, not
restoring the video card from poweroff. Correct me if I'm wrong here.

Secondly if you wanted to do this cleanly you could still do the save
from vm86 in user space and the restore on the 16bit return path having
checked a save was made and that the video bios hasn't gone for a walk.


