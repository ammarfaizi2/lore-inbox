Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268654AbTBZDCk>; Tue, 25 Feb 2003 22:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268684AbTBZDCk>; Tue, 25 Feb 2003 22:02:40 -0500
Received: from rth.ninka.net ([216.101.162.244]:54212 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S268654AbTBZDCi>;
	Tue, 25 Feb 2003 22:02:38 -0500
Subject: Re: Cache aliasing
From: "David S. Miller" <davem@redhat.com>
To: John Newlin <jnewlin@tsoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006a01c2dc9e$e4f685a0$0b01a8c0@john1>
References: <006a01c2dc9e$e4f685a0$0b01a8c0@john1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Feb 2003 19:59:02 -0800
Message-Id: <1046231942.3373.7.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 23:24, John Newlin wrote:
> Would it make more sense to just always ensure that your 
> virtual and physical pages had matching "color" bits?

No, it's actually very difficult to solve the problem this
way.

The reason being that there is always a fixed "kernel virtual
color" every physical page has.  So essentially, if you colored
userspace, you could only put into user virtual address with
color X only pages that also have kernel virtual color X.

