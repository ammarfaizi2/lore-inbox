Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTAVT2P>; Wed, 22 Jan 2003 14:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAVT2P>; Wed, 22 Jan 2003 14:28:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61111 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262780AbTAVT2O>;
	Wed, 22 Jan 2003 14:28:14 -0500
Date: Wed, 22 Jan 2003 11:32:06 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jamie Lokier <jamie@shareable.org>
cc: Ed Tomlinson <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030122193446.GA5438@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.33L2.0301221131370.3511-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Jamie Lokier wrote:

| Randy.Dunlap wrote:
| > | > Why assume HZ=1000?  Would not:
| > | >
| > | > timeout = (unsigned long)(timeout*HZ+(HZ-1))/HZ+1;
| > | >
| > | > make more sense?
| > |
| > | No, that's silly.  Why do you want to multiply by HZ and then divide by HZ?
| >
| > OK, I don't get it.  All Ed did was replace 1000 with HZ and
| > 999 with (HZ-1).  What's bad about that?  Seems to me like
| > the right thing to do.  Much more portable.
| >
| > What if HZ changes?  Who's going to audit the kernel for changes?
|
| You're being dense.  The input timeout is measured in milliseconds;
| see poll(2).  The calculated timeout is measured in jiffies.  Hence
| multiply by jiffies and divide by milliseconds.

Like I said, I didn't get it.  Now I do.  Thanks.

-- 
~Randy

