Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUGVOrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUGVOrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUGVOrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:47:46 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:44142 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265986AbUGVOro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:47:44 -0400
In-Reply-To: <313680C9A886D511A06000204840E1CF08F43052@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF08F43052@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0C006758-DBEE-11D8-9AB1-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: crossgcc <crossgcc@sources.redhat.com>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       "'Andrew Morton'" <akpm@osdl.org>, "'bert hubert'" <ahu@ds9a.nl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: case-sensitive file names during build
Date: Thu, 22 Jul 2004 09:47:25 -0500
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 22, 2004, at 4:25 AM, Povolotsky, Alexander wrote:
>
>> make[3]: *** No rule to make target
>>  `net/ipv4/netfilter/ipt_ecn.o', needed by 
>> `net/ipv4/netfilter/built-in.o'.
>> Stop.
>
> This is the (somewhat questionable) use of ipt_ECN.c and ipt_ecn.c in 
> the
> linux kernel. Windows filesystems are case insensitive, and see this 
> as one
> file.

I had not seen the ECN/ecn problem, but you will also be bitten by .S 
-> .s preprocessing. That's right about the point that I gave up, 
though on OS X I could have created a (case-sensitive) UFS filesystem 
rather than using a (case-insensitive) HFS one.

-- 
Hollis Blanchard
IBM Linux Technology Center

