Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWI2WWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWI2WWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWI2WWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:22:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:5863 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750813AbWI2WWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:22:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=lJERBaOe7rB/A2uImKOGHzaKwHSBxlj2H+zd9CkJnyTaMcgU/oz/CeiAWDXL661wuS6wUAvpUG3eU8kJTnbJXc2HlxZ8Ed6LJudHSla8fDbhS+1P8twQB94/tMPiCYs+PVHdfQPZzvYIlHdIIVI4XO+Yd9YFSixWyCSSRqoa5sM=
Date: Sat, 30 Sep 2006 02:24:22 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com,
       igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
Subject: [RFC] OMAP1 PM Core, Intro 0/2
Message-Id: <20060930022422.4eb949a0.eugeny.mints@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PM Core for OMAP1 platforms.

PM Core provides arch dependent routine to get/set operating points,
hooks up with arhc independent PowerOP layer and utilizes
clock/voltage framework to access hardware. PM Core is expected
to handle additional arch specific actions required to accompany clock/voltage 
framework during operating points change (for example if 
simultaneous coupled clocks/voltage change needs special attention on a 
platform).

Basic building block for PM Core layer is platform power parameter concept. 

Current OMAP implementation relies on "smart" virtual mpu clock
introduced by OMAP1 clock framework (#define
PM_CORE_USE_MPU_CLOCK).

Since voltage framework is not merged into mainline yet
routine to change voltage is temporary implemented in the
PM Core for reference.


