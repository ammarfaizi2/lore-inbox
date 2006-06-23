Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWFWAkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWFWAkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWFWAkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:40:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751565AbWFWAko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:40:44 -0400
Date: Thu, 22 Jun 2006 20:40:33 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: stv680 boolean logic bug.
Message-ID: <20060623004033.GA14911@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks closer to what I believe the original intent was.
(Also fixes line-len to meet CodingStyle)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/media/video/stv680.c~	2006-06-22 20:38:21.000000000 -0400
+++ linux-2.6/drivers/media/video/stv680.c	2006-06-22 20:39:02.000000000 -0400
@@ -974,7 +974,8 @@ static void bayer_unshuffle (struct usb_
 	frame->grabstate = FRAME_DONE;
 	stv680->framecount++;
 	stv680->readcount++;
-	if (stv680->frame[(stv680->curframe + 1) & (STV680_NUMFRAMES - 1)].grabstate == FRAME_READY) {
+	if (stv680->frame[(stv680->curframe + 1) &&
+			(STV680_NUMFRAMES - 1)].grabstate == FRAME_READY) {
 		stv680->curframe = (stv680->curframe + 1) & (STV680_NUMFRAMES - 1);
 	}
 

-- 
http://www.codemonkey.org.uk
