Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUHASVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUHASVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 14:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUHASVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 14:21:39 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:62174 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266081AbUHASVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 14:21:36 -0400
Message-ID: <b71082d804080111213a4df2b6@mail.gmail.com>
Date: Sun, 1 Aug 2004 20:21:36 +0200
From: Bart Alewijnse <scarfboy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: FAT trouble in 2.6.8-rc2-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct me if  I'm wrong, but the fat driver seems to both require and
not accept the codepage mount option:


Aug  1 20:17:28 stretch FAT: Unrecognized mount option
"codepage=cp850" or missing value

..and when I remove it:

Aug  1 20:17:45 stretch FAT: codepage or iocharset option didn't specified
Aug  1 20:17:45 stretch File name can not access proper (mounted as read-only)

Since my fat partition is my major inter-OS storage other than my
server, this is highly annoying.

The relevant fstab line is:
/dev/hda4		/mnt/big	vfat		iocharset=cp850,fmask=0111,codepage=cp850		0 0
(I'm not sure what are good options for both, I was filling utf and
whatnot just to see it that'd help)

--Bart Alewijnse
