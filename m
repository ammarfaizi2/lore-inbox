Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTFWOtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266062AbTFWOtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:49:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24848 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264753AbTFWOtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:49:17 -0400
Date: Mon, 23 Jun 2003 16:03:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Call for old information: i82365.c
Message-ID: <20030623160321.C28325@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2.4.4, Alan submitted a few patches to Linus to add the
following code to i82365.c:

      /*
      SS_DETECT events need a small delay here. The reason for this is that
      the "is there a card" electronics need time to see the card after the
      "we have a card coming in" electronics have seen it.
      */
     if (events & SS_DETECT)
           mdelay(4);

Unfortunately, there are no specifics about the problem.  Since I'm
eliminating the work queue handlers in the pcmcia socket drivers,
this fix doesn't have a logical place inside the socket driver itself.

However, I don't want to loose the fix - it is there to work around some
problem someone was seeing.  If anyone had a problem around this time,
and this fixed it for them, please get in contact with me.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

