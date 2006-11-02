Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752800AbWKBKOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbWKBKOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbWKBKOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:14:12 -0500
Received: from postel.suug.ch ([194.88.212.233]:59065 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1752800AbWKBKOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:14:11 -0500
Date: Thu, 2 Nov 2006 11:14:30 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] taskstats: uglify^Woptimize reply assembling
Message-ID: <20061102101430.GG12964@postel.suug.ch>
References: <20061101182512.GA444@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101182512.GA444@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Oleg Nesterov <oleg@tv-sign.ru> 2006-11-01 21:25
> Thomas, we are doing genlmsg_cancel() before nlmsg_free(), this is
> not necessary. Unless you have evil plans to complicate genetlink
> we can remove a little bit of code, what do you think?

genlmsg_cancel() is only required in error paths for dumping
procedures.
