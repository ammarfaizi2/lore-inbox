Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268925AbUHUJHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268925AbUHUJHB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268924AbUHUJHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:07:01 -0400
Received: from main.gmane.org ([80.91.224.249]:46238 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268929AbUHUJGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:06:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 18:06:42 +0900
Message-ID: <cg73b2$8bs$1@sea.gmane.org>
References: <1093077667.854.69.camel@krustophenia.net> <S268911AbUHUIuB/20040821085001Z+1971@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <S268911AbUHUIuB/20040821085001Z+1971@vger.kernel.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> Here is the very original linux-kernel mailing list, and if I cannot find an
> answer here, then nowhere on earth can this answer be found. I also saw some
> other messages regarding the same issue on the net. None of them is answered
> correctly; and also as if this is a very "forbidden" thing to disable the
> checksums, most replies are as if they are "unbreakable rules of god".
> Really, I am losing my patience with this. It is also very odd to write a
> low-level application in order to just disable a "feature" of the kernel to
> deal with a faulty piece of embedded firmware.

OK, try this, not tested:

replace the return statements with "return 0;" in:

net/ipv4/udp.c, function __udp_checksum_complete, about line 759
net/ipv4/icp_input.c, function __tcp_checksum_complete_user, about line 4070

* line numbers above are for linux-2.6.7

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

