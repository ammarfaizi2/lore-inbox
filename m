Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTFPRmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTFPRmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:42:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:48837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264043AbTFPRmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:42:04 -0400
Message-ID: <3EEE04AC.9040802@gmx.at>
Date: Mon, 16 Jun 2003 19:55:56 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hptraid v0.02 raid 0+1 support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This release fixes some bugs and adds support for raid 0+1. I have also 
done some minor code clean-ups.

Changelog since 0.01-ww1:
=========================
* correct values of raid-1 superbock
* check for availability of all disks
* fixup for raid-1 disknumbering
* do _NOT_ align size to 255*63 boundary
* raid 0+1 support
* bump version number
* release no more devices than available on unload
* remove static variables in raid-1 read path

Notes:
======
I raid 1 and raid 0+1 does not provide support for redundancy. It just 
adds a compatibility layer to support the HPT37X raid volumes.
As far as I can tell, the new raid 0+1 implementation of the HPT374 
(BIOS 3.X) is not supported. The same controller also has raid 5. But 
due to lack of hardware I cannot implement these (Unless I can persuade 
a friend of mine to trash his windows installation.).

Any comments are welcome...

Bye,
Wilfried

