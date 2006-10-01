Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWJANe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWJANe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWJANe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:34:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:65418 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932175AbWJANe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:34:56 -0400
Message-ID: <451FC3FE.8000003@garzik.org>
Date: Sun, 01 Oct 2006 09:34:54 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Netdev List <netdev@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: another ATM bug
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning appears to be real:

drivers/atm/ambassador.c: In function ‘amb_open’:
drivers/atm/ambassador.c:1049: warning: ‘tx_rate_bits’ may be used 
uninitialized in this function

The variable is accessed before the make_rate() error code is checked, 
thus accessing an uninit'd value.

	Jeff


