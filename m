Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTDTWAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbTDTWAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 18:00:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17120 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263723AbTDTWAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 18:00:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 21 Apr 2003 00:12:18 +0200 (MEST)
Message-Id: <UTC200304202212.h3KMCIW15403.aeb@smtp.cwi.nl>
To: davem@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] new system call mknod64
Cc: Andries.Brouwer@cwi.nl, hch@infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the _right_ interface is keeping the <major, minor> tuple explicit

Good! I debated with myself and changed three times between

	mknod64(path, mode, major, minor);

and

	mknod64(path, mode, devhi, devlo);

This becomes the fourth time.

Andries


[My choice is still unsigned int major, minor.
Do you prefer __u32?]
