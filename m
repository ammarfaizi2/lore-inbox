Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271123AbTG1Wvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTG1Wvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:51:47 -0400
Received: from law15-f83.law15.hotmail.com ([64.4.23.83]:14867 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S271123AbTG1Wvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:51:46 -0400
X-Originating-IP: [212.152.91.246]
X-Originating-Email: [ef057@hotmail.com]
From: "Bryan K." <ef057@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: wait_on_page_bit and interactive apps
Date: Mon, 28 Jul 2003 22:51:45 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law15-F835uZJorwBpP00011ff7@hotmail.com>
X-OriginalArrivalTime: 28 Jul 2003 22:51:45.0590 (UTC) FILETIME=[D20B9D60:01C3555A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the function wait_on_page_bit there is this code:

	...
if (test_bit(bit_nr, &page->flags)) {
	sync_page(page);
	io_schedule();
}
	...

If I move the io_schedule() before sync_page(page), this will improve the 
response time of interactive applications?

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

