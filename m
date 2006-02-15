Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422955AbWBOFTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbWBOFTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWBOFTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:19:21 -0500
Received: from smtp.lairds.com ([66.90.77.220]:52430 "EHLO smtp.lairds.com")
	by vger.kernel.org with ESMTP id S1422955AbWBOFTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:19:20 -0500
Date: Wed, 15 Feb 2006 00:19:08 -0500
From: Kyler Laird <kyler-keyword-lkml00.e701c2@lairds.com>
To: linux-kernel@vger.kernel.org
Subject: drivers/media/video/saa7115.c misreports max. value of contrast and saturation
Message-ID: <20060215051908.GF13033@snout>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For changes to V4L2_CID_CONTRAST and V4L2_CID_SATURATION, the value is
checked by "if (ctrl->value < 0 || ctrl->value > 127)" yet the maximum
value in v4l2_queryctrl is set to 255 for both of these items.  This
means that programs (like MythTV) which set the contrast and saturation
to the midvalue (127) get *full* contrast and saturation.  (It's not
pretty.)

Setting the maximum values to 127 solves this problem.

Please copy me on responses.

Thank you.

--kyler

