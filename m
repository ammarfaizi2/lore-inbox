Return-Path: <linux-kernel-owner+w=401wt.eu-S1751976AbWLVTUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWLVTUU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbWLVTUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:20:20 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:39574 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751976AbWLVTUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:20:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=5o29Tne0FKw5RW0UOaBQxZrV85lqSh1G1LG9eS8K3YmRmxHv2Mc7TVmuFpRhWZU+5JAVCE+bs7Js0oA8AlVNulSBT4hLsLFD39iYvc+KOeAsWXgIg+RQJGXaXxpSzwSvUy90LMT02kPxzk5Bi4b7koe/L+uDt5aTCzsoUUvHpNo=  ;
X-YMail-OSG: 64F3Q.MVM1mXEYb4vUIaDdq4wExAgs.g3d7bKFdfZHanrdeW2UMl_0UmM7nWoVgMU6xesZshbL4rppoGgP_iIhN5HVnKGHLHJVpjILYHp0iaudsXxHw6UF8etwrfF9ZgAXD9_qccM8L4aVQ-
Date: Fri, 22 Dec 2006 11:20:14 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 0/6] input:  ads7846 touchscreen driver updates
Cc: tony@atomide.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192015.3B47E1EEFA8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this are six patches that bring the ads7846 driver up to
date with respect to the patches in the Linux-OMAP tree.  There was
some unfortunate divergence, but the need for that is gone (now that
issues with the omap_uwire SPI controller driver are resolved).

 - allow pluggable lcd-specific input conditioning filters
 - optionally leave vREF on for board-specific sample improvement
 - be more compatible with hwmon framework
 - switch to hrtimer
 - force use of SPI mode 1
 - use explicit detection of penup signal (gpio) state

Most of this came from Nokia work, ISTR for better N770 support.

That patch for PENUP handling should also be useful for the ads7843
updates being provided by Atmel.


- Dave
