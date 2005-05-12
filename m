Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVELSTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVELSTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVELSTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:19:46 -0400
Received: from adsl-66-218-37-216.dslextreme.com ([66.218.37.216]:55007 "EHLO
	tyanhuey") by vger.kernel.org with ESMTP id S262096AbVELSTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:19:44 -0400
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.30 xfs bug
Date: Thu, 12 May 2005 11:17:01 -0700
User-Agent: KMail/1.8
Organization: Duskglow Consulting
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121117.01192.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.30 will not compile if XFS is turned on, but XFS debugging is not.  
Culprit is:

fs/xfs/linux-2.4/xfs_buf.c line 1076.  Apparently pagebuf_lock_value is used 
somewhere else, even if it's not defined because debugging is off.

--Russell
