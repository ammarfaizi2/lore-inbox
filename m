Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSLaIdR>; Tue, 31 Dec 2002 03:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSLaIdR>; Tue, 31 Dec 2002 03:33:17 -0500
Received: from are.twiddle.net ([64.81.246.98]:32385 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262506AbSLaIdQ>;
	Tue, 31 Dec 2002 03:33:16 -0500
Date: Tue, 31 Dec 2002 00:41:38 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [TGAFB] implement the imageblit acceleration hook
Message-ID: <20021231004138.A13860@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from

	bk://are.twiddle.net/tgafb-2.5


r~



 drivers/video/tgafb.c |  255 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/video/tgafb.h |   27 +++++
 2 files changed, 281 insertions, 1 deletion

through these ChangeSets:

<rth@are.twiddle.net> (02/12/31 1.954.2.7)
   [TGAFB] Implement the fb_imageblit hook.
   
   Speeds up rendering of text by around 7x for 8bpp cards,
   as you'd expect from the difference in the volume of data
   passed across the bus.  Thus the win should be about 31x
   for 32bpp cards.
