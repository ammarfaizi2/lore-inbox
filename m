Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUGWNVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUGWNVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 09:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267710AbUGWNVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 09:21:55 -0400
Received: from vhost12.digitarus.com ([194.242.150.12]:46782 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S267708AbUGWNVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 09:21:32 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <410110D1.4050501@wiggly.org>
Date: Fri, 23 Jul 2004 14:21:21 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: cdrom.c : dropping to single frame dma fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens,

Well I got a patch to stop cdrom.c from dropping to single frame as long 
as it has done multi-frame at least once and it seems to work for me but 
I obviously am not sure what implications this will have for lots of 
other users.

I was wondering if there was a way for the cdrom module to know when the 
media gets changed so that the flag can be cleared and only reset if we 
can do multi-frame DMA with the new media?

I have been digging through the code but can't see an obvious place 
where this happens, pointers and other comments welcome.

Currently I've got 2.6.7-rc3 patched, would you accept or you want me to 
check it goes cleanly into the latest and greatest?

Cheers,

   Nige

