Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTDJC5g (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 22:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTDJC5g (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 22:57:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263775AbTDJC5f (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 22:57:35 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: kernel support for non-english user messages
Date: Thu, 10 Apr 2003 03:08:33 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b72n7h$fgd$1@penguin.transmeta.com>
References: <3E93A958.80107@si.rr.com>
X-Trace: palladium.transmeta.com 1049944134 24269 127.0.0.1 (10 Apr 2003 03:08:54 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Apr 2003 03:08:54 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E93A958.80107@si.rr.com>, Frank Davis  <fdavis@si.rr.com> wrote:
>
>I wish to suggest a possible 2.6 or 2.7 feature (too late for 2.4.x and 
>2.5.x, I believe) that I believe would be helpful. Currently, printk 
>messages are all in english, and I was wondering if printk could be 
>modified to print out user messages that are in the default language of 
>the machine. For example,

This has come up before.

The answer is: go ahead and do it, but don't do it in the kernel. Do it
in klogd or similar.

I refuse to clutter the kernel with inane and fragile (and totally
unmaintainable) internationalization code. The string lookup can equally
well be done in user space where it isn't a stability and complexity
issue.

		Linus
