Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbTE1J6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTE1J6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:58:50 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:9745 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264646AbTE1J6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:58:48 -0400
Date: Wed, 28 May 2003 11:12:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: DVB updates, 2nd try
Message-ID: <20030528111202.A27811@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>
References: <3ED3634A.2000608@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3ED3634A.2000608@convergence.de>; from hunold@convergence.de on Tue, May 27, 2003 at 03:08:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01-av7110-firware.diff

 - looks fine (obsiously :)).  If the old driver works with the
   new firware I'd suggets sending it to Linux now

02-saa7146-core.diff

 - the WRITE_RPS0 macro is ugly as hell, you probably want to
    replace it with a proper inline.  But you can leave this to
    a later patch.  If it doesn't need the other updates I'd
    suggest submitting it now.

03-dvb-core.diff

 - okay, this is a big one..  Could you submit the typedef removal
   as a first separate patch so the actual changes are reviewable
   more easily?
 - please use <linux/types.h> not <asm/types.h> everywhere
 - please include <asm/*.h> headers after <linux/*.h> ones
 - This is wrong:
-static struct dvb_device dvbdev_dvr = {
+static
+struct dvb_device dvbdev_dvr = {
   instead of breaking the indention rather fix the reamining parts
   of the driver
 - dvb_kernel_thread_setup doesn't need the BKL

04-dvb-drivers.diff

 - looks ok

05-update-frontends.diff

 - looks ok

06-new-frontend.diff

 - looks ok (except for the above mentioned indentation issues)

07-dvb-core-lib-user.diff

 - looks ok (obviously)

08-analog-saa7146-update.diff

 - looks ok (obviously)

09-saa7111-i2c-fix.diff

 - looks ok (obviously)

