Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRKNE6a>; Tue, 13 Nov 2001 23:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280118AbRKNE6V>; Tue, 13 Nov 2001 23:58:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280120AbRKNE6K>;
	Tue, 13 Nov 2001 23:58:10 -0500
Date: Tue, 13 Nov 2001 20:57:29 -0800 (PST)
Message-Id: <20011113.205729.71087461.davem@redhat.com>
To: kukuk@suse.de
Cc: vonbrand@inf.utfsm.cl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011113162102.A2305@suse.de>
In-Reply-To: <torvalds@transmeta.com>
	<200111131410.fADEA9L8023291@pincoya.inf.utfsm.cl>
	<20011113162102.A2305@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This first patch is wrong.  lv_block_exception needs translating
because the types are of a different size on sparc32 than on sparc64.

Specifically the first member of lv_block_exception_t is
'struct list_head', which are two pointers, which is 8 bytes
on sparc32 and 16 bytes on sparc64.

Please do not apply these patches.

Franks a lot,
David S. Miller
davem@redhat.com
