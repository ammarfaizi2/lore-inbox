Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUB2NFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 08:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUB2NFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 08:05:32 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:46536 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262049AbUB2NFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 08:05:21 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Date: Sun, 29 Feb 2004 13:05:19 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <4041E38F.31264.2D8C0D2E@localhost>
In-reply-to: <87vflqt61a.fsf@devron.myhome.or.jp>
References: <4041D3B9.24667.2D4E3207@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks. Umm.. strange, already NAPI reverted.
> Does these patches change the behavior?
> 
> 
> debug + revert01 + revert02 + revert03

**BINGO**

Excellent.  patch03 has stopped the timeouts.  I have just tested.  I 
moved (via ftp) a 30MB file from network -> eth0, and at the same 
time downloaded a 30MB file (via httpd) from the Internet -> eth1.

I was getting 10Mbs internal, and 30Kbs external (as expected).  NO 
TIMEOUTS :) :)

Before, just the internal FTP timed out in 5 seconds.

dmesg is basically very quiet:

http://www.linicks.net/8139too_debug/bingo.txt

> after
> 
> debug + revert01 + revert02 + revert03 + revert04

I haven't applied patch04.

I will continue to run the debug kernel.

Thank you :)

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

