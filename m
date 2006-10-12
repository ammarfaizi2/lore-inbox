Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWJLTdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWJLTdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWJLTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:33:15 -0400
Received: from web58107.mail.re3.yahoo.com ([68.142.236.130]:3449 "HELO
	web58107.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1750901AbWJLTdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:33:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e7r7SzMFsq2dRp2vIaf+hbn155nLdUBEeCYGc1aAuYDsNWI8AgVRSXI6tVJubjb+m+MDnVs6EhC9j+O7qOGs2c28JHFyLS944JSkTQfcb8X3SYD2O0sg1EJisdhF6VRKqoEtbXTR3ghQXESPTUlvDDkXWrlB67bhcFzjtnNFQWk=  ;
Message-ID: <20061012193313.4281.qmail@web58107.mail.re3.yahoo.com>
Date: Thu, 12 Oct 2006 12:33:13 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: USB performance bug since kernel 2.6.13 (CRITICAL???)
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending because linux-usb-devel@sourceforge.net bounced right back to me.  Sorry for the multiple messages!)

----- Forwarded Message ----
From: Open Source <opensource3141@yahoo.com>
To: linux-kernel@vger.kernel.org; linux-usb-devel@sourceforge.net
Sent: Thursday, October 12, 2006 12:21:56 PM
Subject: USB performance bug since kernel 2.6.13 (CRITICAL???)

Hi all, 
 
I am  writing regarding a performance issue that I recently observed after upgrading from kernel 2.6.12 to 2.6.17.  I did some hunting around and have found that the issue first arises in 2.6.13.

I am using a device that submits URBs asynchronously using the libusb devio infrastructure.  In version 2.6.12 I am able to submit and reap URBs for my particular application at a transaction rate of one per millisecond.  A transaction consists of a single WRITE URB (< 512 bytes) followed by a single READ URB (1024 bytes).  Once I upgrade to version 2.6.13, the transactional rate drops to one per 4 milliseconds!

The overall performance of a particular algorithm is increased from a total execution time of 75 seconds to over 160 seconds.  The only difference between the two tests is the kernel.  Microsoft Windows executes the algorithm in 70-75 seconds!

I am using a Fedora Core distribution with FC4 kernels for testing.  Is there some new incantation that is required in my user-mode driver to get around a "feature" in recent kernels?  Does anyone else know about this?  I was not able to easily find discussion about this on the newsgroups.  It appears that this problem has been around for a while, if it is indeed a problem.

I am not a subscriber to the linux-kernel mailing list but have cross-posted to it since this seems like a serious enough issue.  Please continue to keep any responses on linux-usb-devel as well so I can see them in my email box.

Thank you,
Beleaguered Open Source Fan










