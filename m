Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWIID3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWIID3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWIID3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:29:42 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:40182 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932106AbWIID3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:29:41 -0400
Date: Fri, 08 Sep 2006 23:29:39 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: netdevice name corruption is still present in 2.6.18-rc6-mm1
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-netdev <linux-netdev@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-netdev <linux-netdev@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-id: <20060909032939.GA3087@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I would like to confirm that issue with netdevice name corruption
is still present in 2.6.18-rc6-mm1 and extremely easy to reproduce
(at least on my system) with 100% hit rate.

All I have to do is 'sudo /etc/init.d/networking stop'. And here we go:

Sep  8 22:50:11 nickolas kernel: [events/1:7]: Changing netdevice name from [ath0] to [\200^C^BÂ\206]

Does not look like an userspace issue at all...

Last kernel which is known to be working (for me) is 2.6.18-rc1-mm2.
Sorry, I now that a lot of things had changed since then,
but I was somewhat busy last couple of months...

Please let me know if I can help somehow to debug it.

Thank you,
	Nick Orlov.

P.S. I admit that I'm using "binary only atheros driver" which makes
this report a lot less legit. But seems like people experiencing the
very same issue w/o any closed-source drivers loaded...

P.P.S I don't even have NetworkManager executable on my system
(Debian unstable updated on daily basis), so NetworkManager have
nothing to do with it.

-- 
With best wishes,
	Nick Orlov.

