Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVD3RCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVD3RCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 13:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVD3RCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 13:02:13 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:19642 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261301AbVD3RCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 13:02:06 -0400
Message-ID: <4273BBB4.22EA0EAB@tv-sign.ru>
Date: Sat, 30 Apr 2005 21:09:08 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Juergen Kreileder <jk@blackdown.de>
Subject: Re: Fw: [Bug 4559] New: cfq scheduler lockup: NMI oops while runningltp 
 - 20050207  on 2.6.12-rc2-mm3 with kdump enabled
References: <20050429000038.1da6f2e1.akpm@osdl.org> <42737D3A.ABEF2022@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> One option is to change __mod_timer() so that it would not
> switch ->base when the timer is already running. But this
> would be behavioural change: currently __mod_timer() guarantees
> that the timer would be armed on the local cpu.

Is it acceptable? If yes, I'll send the patch tomorrow.

I don't see another solution.

Oleg.
