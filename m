Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTFEQLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbTFEQLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:11:32 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:26869 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP id S264733AbTFEQLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:11:30 -0400
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: linux-kernel@vger.kernel.org
Subject: Question: sk_buff and destructor
Date: Thu, 5 Jun 2003 12:24:33 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306051224.33510.ADharankar@ATTBI.Com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

One ethernet driver I am working with, allocates sk_buff using 
dev_alloc_skb to send the received data to network layers above.
It also sets the sk_buff->dev field to its own net_device.

If the driver also sets the sk_buff->destructor to be one its
functions: can the sk_buff->dev be guaranteed to be the same
as when the destructor is called? I could not find any driver
making use of this struct member.


I am attempting to detect an sk_buff leak, almost likely in
the driver. Is there any other pointers/ideas I might be able to
use to debug this leak? I am using Linux 2.4.20.


Best regards,
-Arun.

