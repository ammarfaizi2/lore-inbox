Return-Path: <linux-kernel-owner+w=401wt.eu-S1423048AbWLUTZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423048AbWLUTZ5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423054AbWLUTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:25:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33793 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423048AbWLUTZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:25:56 -0500
Date: Thu, 21 Dec 2006 11:25:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: performance regression from block merge
Message-Id: <20061221112540.e4ba58bc.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, elapsed time for `mke2fs /dev/hdc5' with the anticipatory scheduler
(at least) has gone from nine seconds to sixty as a result of the recent
block merge.

This is the enty enth time that block code has been slammed into mainline
without having had exposure to -mm testers or even to me personally, and it
it the second time (at least) that obvious regressions have occurred as a
result.  I have a New Year's resolution for you ;)
