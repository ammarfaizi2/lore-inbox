Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272056AbTG2UTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272058AbTG2UTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:19:04 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26272 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272056AbTG2UTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:19:03 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 29 Jul 2003 22:18:56 +0200 (MEST)
Message-Id: <UTC200307292018.h6TKIum18958.aeb@smtp.cwi.nl>
To: Valdis.Kletnieks@vt.edu, manfred@colorfullife.com
Subject: Re: [PATCH] select fix
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Manfred Spraul <manfred@colorfullife.com>

	Valdis.Kletnieks@vt.edu wrote:

	> Would including all 3 conditions make sense?

I hesitated for a moment. These conditions are not entirely
equivalent and neither implies the other. But Manfreds
version is better. Many drivers have a write_room() that
only counts characters and the corresponding write() will fill
the buffer and only check tty->stopped before actually transmitting.
So write_room() is a better predictor.

Andries

