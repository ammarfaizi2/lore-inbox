Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUCSPRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbUCSPRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:17:33 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:5005 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263018AbUCSPRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:17:32 -0500
Message-Id: <5.1.0.14.2.20040319155257.00ac0af8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 19 Mar 2004 16:17:45 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.6.xx - linux/firmware.h - missing include
Cc: ranty@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: EwzOJ-ZCYeWRfOBEeVvr4NDaYNLUvM9ydW8RdLmLsB32O6E+TBP9cF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype for request_firmware uses a struct device parameter.
This is only defined if linux/device.h is included.
Fix is simple : include linux/device.h in linux/firmware.h
(Yes, I know we can do the include in a driver, as per the
  example in Documentation;however, the above obviates the need
  for ugly ifdef's for common 2.4/2.6 code and has no downside)
Manuel, can you implement if you agree ?


