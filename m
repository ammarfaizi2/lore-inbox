Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266475AbUF3FJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUF3FJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUF3FJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:09:46 -0400
Received: from [203.178.140.15] ([203.178.140.15]:6410 "EHLO yue.st-paulia.net")
	by vger.kernel.org with ESMTP id S266475AbUF3FJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:09:42 -0400
Date: Wed, 30 Jun 2004 14:10:52 +0900 (JST)
Message-Id: <20040630.141052.524310146.yoshfuji@linux-ipv6.org>
To: drepper@redhat.com
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <40E24573.5030403@redhat.com>
References: <40E1BE7D.7070806@redhat.com>
	<20040629141915.0268b741.davem@redhat.com>
	<40E24573.5030403@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <40E24573.5030403@redhat.com> (at Tue, 29 Jun 2004 21:45:39 -0700), Ulrich Drepper <drepper@redhat.com> says:

> David S. Miller wrote:
> > Ulrich, is there a major reason why you can't use RTNETLINK for
> > your implementation?  It behaves as you desire and gives you
> > all of the link information you are after, in place of SIOCGIFCONF.
> 
> When was the netlink interface introduced?  The ioctl() code is most
> probably older and therefore we would still get wrong results on old
> kernels.  I don't know the reason why  you hesitate, but the patch seems
> really harmless and, as you pointed out, more compatible with the BSD
> version.

2.2.x or later have (modern) netlink support.

--yoshfuji
