Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVHDBmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVHDBmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVHDBjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:39:42 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:14748 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261744AbVHDBgy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:36:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y9nTLOKjJCWq+Ty7Phhqr2LqSYFtJXdhsbTRA1nsqjsONG1oB2DIwAYgV+3y/h6fqORpDcASvBSrfAyRwJaA2UBLhKTCpX34WwpqWtGHCRIh4ePGTfkpRQ1C9xX4d7978QBiw0lcm2Tad6UiAmWERZrDW41+96NifESs+yiphLE=
Message-ID: <92fc8b8105080318367f77fed1@mail.gmail.com>
Date: Wed, 3 Aug 2005 18:36:51 -0700
From: Chris Budd <budorola@gmail.com>
Reply-To: Chris Budd <budorola@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: 2.4.21: Sharing interrupts with serial console
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read http://www.tldp.org/HOWTO/Remote-Serial-Console-HOWTO/preparation-setport.html
and http://www.linux-mips.org/archives/linux-mips/2004-04/msg00134.html
and other items, but I still have not found the answers to the
following questions:

1.  The rs_init function in ./linux-2.4.21/drivers/char/serial.c
explicitly states "The interrupt of the serial console port can't be
shared."  Does this include *ALL* interrupts?  The code checks for
sharing only with other serial devices, not *ALL* types of devices
like I2C, RTC, etc.

2.  While the presence of the comment about not sharing was nice, it
does not explain "why?"  Why can't we share the serial console
interrupt?  The serial console seems to work when I alter serial.c to
skip this check for the sharing of interrupts with the serial console.

3.  Does the hardware platform matter?  We are running Linux 2.4.21 on
an embedded XScale(ARM)-based board.

Thanks,
Chris.
