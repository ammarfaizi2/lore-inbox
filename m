Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUIQLDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUIQLDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUIQLDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:03:09 -0400
Received: from gandalf.ios.edu.pl ([193.0.91.125]:16537 "EHLO
	gandalf.ios.edu.pl") by vger.kernel.org with ESMTP id S268672AbUIQLC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:02:58 -0400
Message-ID: <414AC45B.60404@ios.edu.pl>
Date: Fri, 17 Sep 2004 13:02:51 +0200
From: =?ISO-8859-2?Q?Marcin_Ro=BFek?= <marcin.rozek@ios.edu.pl>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c
References: <414834AA.70602@ios.edu.pl> <20040915112102.GA1992@logos.cnet> <414844C5.6080802@ios.edu.pl> <20040915124449.GB2963@logos.cnet>
In-Reply-To: <20040915124449.GB2963@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-From: marcin.rozek@ios.edu.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Yes it is quite serious... the VM is trying to free a page with ->mapping 
> set (probably a pagecache page) which is not valid thing to happen (thus the BUG).
> 
> You can move to v2.4.27 to confirm you see or do not see the problem there.
It's a grsecurity bug: http://forums.grsecurity.net/viewtopic.php?t=933
On clean 2.4.27 everything works fine.
It happens only when MPROTECT is turned off in the kernel.

Regards,
Marcin
