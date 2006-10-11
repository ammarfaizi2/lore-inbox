Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161350AbWJKTPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161350AbWJKTPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161353AbWJKTPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:15:20 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:24709 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161350AbWJKTPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:15:17 -0400
Date: Wed, 11 Oct 2006 21:13:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
In-Reply-To: <452D3BB6.8040200@zytor.com>
Message-ID: <Pine.LNX.4.61.0610112112450.9822@yvahk01.tjqt.qr>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk>
 <452D3BB6.8040200@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> %p will do no such thing in the kernel.  As for the difference...  %x
>> might happen to work on some architectures (where sizeof(void
>> *)==sizeof(int)),
>> but it's not portable _and_ not right.  %p is proper C for that...

Ah I see your point, but then again, %lx could have been used. Unless 
there is some arch where sizeof(long) != sizeof(void *).

> It's really too bad gcc bitches about %#p, because that's arguably The Right
> Thing.

ack. Make a bug report perhaps?

	-`J'
-- 
