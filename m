Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281493AbRKUDti>; Tue, 20 Nov 2001 22:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281497AbRKUDt2>; Tue, 20 Nov 2001 22:49:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52878 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281493AbRKUDtU>;
	Tue, 20 Nov 2001 22:49:20 -0500
Date: Tue, 20 Nov 2001 19:49:15 -0800 (PST)
Message-Id: <20011120.194915.90520140.davem@redhat.com>
To: anton@samba.org
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011121131900.B13279@krispykreme>
In-Reply-To: <20011120170219.A10454@krispykreme>
	<20011120181131.F1961-100000@gerard>
	<20011121131900.B13279@krispykreme>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Wed, 21 Nov 2001 13:19:01 +1100
   
   I didnt make these changes and it would seem we can link IO address <->
   pci bus,dev,fn in other ways, if it turns out many drivers cannot use u64
   for IO ports then we will have to investigate them.

Any driver which cannot handle PCI I/O resources being an unsigned
long is completely broken.

They are 64-bits on Sparc64 already, and this is the type of
PCI resource values.
