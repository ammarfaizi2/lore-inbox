Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUAKDsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUAKDsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:48:43 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:57017 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265754AbUAKDsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:48:42 -0500
Subject: VT locking patch #2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1073792656.750.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 14:44:16 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

Here's a new version of the patch, against 2.6.1 bk.

I went more in depth into some of the calls in vt_ioctl and I think
fixed a few more races along with a possible false-positive. I added
the check for oops in progress too.

There are matching bits that have to go to fbdev as well, they'll be
part of the fbdev merge.

James: Do no include this patch with your big fbdev patches please,
it makes things more confusing. I'll send you separately the patches
to apply to fbdev to add locking in the right place.

Ben.


