Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWCCEju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWCCEju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCCEju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:39:50 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:37283 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751051AbWCCEjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:39:49 -0500
Date: Fri, 03 Mar 2006 13:39:48 +0900 (JST)
Message-Id: <20060303.133948.52162445.nemoto@toshiba-tops.co.jp>
To: akpm@osdl.org
Cc: ram.gupta5@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix potential jiffies overflow
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060302194841.20737363.akpm@osdl.org>
References: <20060302184502.5177c9db.akpm@osdl.org>
	<20060303.123110.32501622.nemoto@toshiba-tops.co.jp>
	<20060302194841.20737363.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 2 Mar 2006 19:48:41 -0800, Andrew Morton <akpm@osdl.org> said:
>> Well, jiffies will lose 49.7 days...  Then, how about this?  We can
>> sleep 136 years.

akpm> but...

akpm> 	wall_jiffies += sleep_length;

akpm> wall_jiffies is 32-bit.

Yes ...  and I think wall_jiffies can be removed completely (with
update_times() cleanup).  Of course it should not be 2.6.16 material.

---
Atsushi Nemoto
