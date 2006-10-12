Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWJLTzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWJLTzB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWJLTzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:55:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37787 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750720AbWJLTzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:55:00 -0400
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
From: Lee Revell <rlrevell@joe-job.com>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061012193313.4281.qmail@web58107.mail.re3.yahoo.com>
References: <20061012193313.4281.qmail@web58107.mail.re3.yahoo.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 15:55:55 -0400
Message-Id: <1160682956.24931.75.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 12:33 -0700, Open Source wrote:
> I am using a device that submits URBs asynchronously using the libusb
> devio infrastructure.  In version 2.6.12 I am able to submit and reap
> URBs for my particular application at a transaction rate of one per
> millisecond.  A transaction consists of a single WRITE URB (< 512
> bytes) followed by a single READ URB (1024 bytes).  Once I upgrade to
> version 2.6.13, the transactional rate drops to one per 4
> milliseconds!

The kernel's internal tick rate was lowered from 1000Hz to 250Hz
starting with 2.6.13.  Rebuild with CONFIG_HZ=1000 and the performance
should return to normal.

Lee

