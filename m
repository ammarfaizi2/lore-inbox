Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUIRJyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUIRJyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 05:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUIRJyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 05:54:53 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:22147 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S267232AbUIRJyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 05:54:52 -0400
Message-ID: <414C05F0.8040401@drzeus.cx>
Date: Sat, 18 Sep 2004 11:54:56 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 0/3] MMC compatibility fix
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following three patches resolve the issues with some MMC cards 
failing to work with the current MMC layer.

Some of the issues are because of cards failing to comply with 
standards. But since we cannot fix the cards we have to deal with the 
problems on our side.

All three patches solve initialisation problems:

- Standard requires a GO_IDLE before changing the OCR mask.

- Standard doesn't define how long to wait for cards to power up. The 
current time as been shown to be too short.

- Empty OCR mask causes some cards to fail (even though an empty OCR is 
ok according to the standard).

--
Pierre Ossman
