Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVKQPjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVKQPjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVKQPjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:39:48 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:27312 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1751345AbVKQPjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:39:42 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: A problem with ktimer
User-Agent: KMail/1.8
Cc: kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 17 Nov 2005 16:39:26 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511171639.27565.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I know that ktimer is not yet part of the main tree of the Linux kernel.

However, maybe someone can help me to understand why the following code in a 
module makes crash my x86_64.

Many thanks,

             Claudio



struct ktimer mytimer;

void myfunction()
{
        int i;
}


static int module_insert(void)
{
   ktime_t mytime = ktime_set(1,0);
   mytimer.function = myfunction;
   mytimer.data = NULL;
   ktimer_init(&mytimer);
   ktimer_start(&mytimer, &mytime, KTIMER_REL);
   //...
}
