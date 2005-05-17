Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVEQWf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVEQWf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVEQWWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:22:49 -0400
Received: from [85.8.12.41] ([85.8.12.41]:10666 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262008AbVEQWMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:12:17 -0400
Message-ID: <428A6C3A.40505@drzeus.cx>
Date: Wed, 18 May 2005 00:12:10 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 0/2] Proper MMC command classes support
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC block layer currently contains an if-clause which only seems to
serve the purpose of killing forward compatibility:

	if (card->csd.cmdclass & ~0x1ff)
		return -ENODEV;

This checks for (what I presume) command classes that were undefined
when this code was written. Since these are now starting to be used,
this code is causing a lot of problems. The following two patches tries
to make a more sane check of the command classes.

(Note. The new command class is for high speed cards to allow higher
transfer rates than normal)

Rgds
Pierre
