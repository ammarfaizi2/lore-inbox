Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTEJNuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTEJNuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:50:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20634 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264125AbTEJNuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:50:24 -0400
Date: Sat, 10 May 2003 07:02:34 -0700 (PDT)
Message-Id: <20030510.070234.21899554.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: hch@infradead.org, romieu@fr.zoreil.com, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE
 he_init_one() (and an iphase patch too!) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>
References: <20030510062015.A21408@infradead.org>
	<200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Sat, 10 May 2003 09:52:49 -0400

   In message <20030510062015.A21408@infradead.org>,Christoph Hellwig writes:
   >kfree(NULL) if perfectly fine.  Also please untangle all this if
   >statements to two separate lines.
   
   but its ok for usb drivers?
   
Bad ugly code in one area of the kernel is not an excuse
for it in other areas :-)

Really, putting a statement on the same line as the if
test controlling it's execution is very unreadable.  Most
people's eyes expect to see:

	if (test)
		IF_CODE_BLOCK

Whether it be one or more lines.  I cannot count how many locking bugs
escaped for a long time because of utter shit like this:

	if (test) return 0;

