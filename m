Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDWWEV>; Mon, 23 Apr 2001 18:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRDWWEL>; Mon, 23 Apr 2001 18:04:11 -0400
Received: from t2.redhat.com ([199.183.24.243]:5625 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132327AbRDWWD5>; Mon, 23 Apr 2001 18:03:57 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <001d01c0cc33$7e62daa0$5517fea9@local> 
In-Reply-To: <001d01c0cc33$7e62daa0$5517fea9@local> 
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org
Subject: Re: filp_open() in 2.2.19 causes memory corruption 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Apr 2001 23:03:48 +0100
Message-ID: <3942.988063428@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


manfred@colorfullife.com said:
> Are you sure the trace is decoded correctly?

> > CPU:    0 
> > EIP:    0010:[sys_mremap+31/884]  

Probably not. It looks like it was munged by klogd. Some distributions are 
still shipping with klogd configured to destroy the original information on 
the way to the log, without even making it do a sanity check that the 
System.map it's using actually matches the current kernel.

Jeff, please disable the broken klogd symbol munging and reproduce it,
running the oops through ksymoops manually. Ksymoops should have built-in 
sanity checks on the System.map it tries to use.

Also, please make sure you report this as a serious bug with the vendor of 
whatever distribution you're running on this box.

--
dwmw2


