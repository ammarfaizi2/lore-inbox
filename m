Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161353AbWJKTQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbWJKTQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbWJKTQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:16:44 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20411 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161353AbWJKTQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:16:43 -0400
Message-ID: <452D4306.3040407@zytor.com>
Date: Wed, 11 Oct 2006 12:16:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk> <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk> <452D3BB6.8040200@zytor.com> <Pine.LNX.4.61.0610112112450.9822@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610112112450.9822@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> %p will do no such thing in the kernel.  As for the difference...  %x
>>> might happen to work on some architectures (where sizeof(void
>>> *)==sizeof(int)),
>>> but it's not portable _and_ not right.  %p is proper C for that...
> 
> Ah I see your point, but then again, %lx could have been used. Unless 
> there is some arch where sizeof(long) != sizeof(void *).

That really makes gcc bitch, *and* it's wrong for a whole bunch of reasons.

>> It's really too bad gcc bitches about %#p, because that's arguably The Right
>> Thing.
> 
> ack. Make a bug report perhaps?

Maybe.  They'll probably say "the C standard says so" :-/

	-hpa

