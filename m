Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUHBPxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUHBPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUHBPxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:53:16 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:60041 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266565AbUHBPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:53:12 -0400
Message-ID: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
Date: Mon, 2 Aug 2004 08:53:12 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: DRM code reorganization
To: lkml <linux-kernel@vger.kernel.org>
Cc: Dave Airlie <airlied@linux.ie>, Ian Romanick <idr@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>4) DRM code reorganization. There were several requests to reorganize
>DRM to more closely follow the Linux kernel guidelines. This
>reorganization should occur before new features are added.

What should be the model for reorganizing DRM? An obvious change is
eliminate the naming macros. 

Another is to change to a personality with helper library model like
fbdev has. All of the common DRM code would go into a library module.
Each card would then have a small device specific module which depends
on the library module for common code. 

ian: what about splitting the current memory management code into a
module that can be swapped for your new version?

Are other structure changes needed?




=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
