Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTIQS3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTIQS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:29:01 -0400
Received: from [65.198.37.67] ([65.198.37.67]:55470 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S262626AbTIQS3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:29:00 -0400
Subject: 2.4.23-pre4 compile failure in hw_random.c and aic7xxx on amd64
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063823338.7731.9.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 11:28:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hw_random.c: In function `via_init':
hw_random.c:433: error: `MSR_VIA_RNG' undeclared (first use in this function)
hw_random.c:433: error: (Each undeclared identifier is reported only once
hw_random.c:433: error: for each function it appears in.)
hw_random.c: In function `via_cleanup':
hw_random.c:459: error: `MSR_VIA_RNG' undeclared (first use in this function)

The strange bit is that I didn't even have Intel/AMD/VIA hardware rng
configured, only AMD 768/8??? rng support.  So it seems like some sort
of bug in oldconfig.  After removing CONFIG_HW_RANDOM I can build again.

I also still have compile failures in drivers/scsi/aic7xxx due to
Werror.

-jwb

