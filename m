Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbULFNLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbULFNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbULFNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:11:25 -0500
Received: from puma.inf.ufrgs.br ([143.54.11.5]:16523 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id S261517AbULFNLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:11:15 -0500
In-Reply-To: <92A26C52-44B7-11D9-A62F-000A957B2B6C@inf.ufrgs.br>
References: <92A26C52-44B7-11D9-A62F-000A957B2B6C@inf.ufrgs.br>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2EC8FF2C-4788-11D9-859D-000A957B2B6C@inf.ufrgs.br>
Content-Transfer-Encoding: 7bit
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
X-Image-Url: http://www.inf.ufrgs.br/~drebes/drebes.tif
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Subject: Re: GFP_ATOMIC vs GFP_KERNEL in netfilter module
Date: Mon, 6 Dec 2004 11:10:21 -0200
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/12/2004, at 21:12, Roberto Jung Drebes wrote:

> If I use GFP_ATOMIC, I don't get the error, but I think timers are not 
> being called after the delay. I have a similar code for transmition, 
> which works OK with GFP_KERNEL (delays messages) but with GFP_ATOMIC 
> it does also not delay.
>
> I test delay with ping, and I am running kernel 2.6.8-1.521 from 
> Fedora Core 2.
>
> What am I doing wrong?

Just for reference, everything was working alright with GFP_ATOMIC. I 
thought the timer was not installed because ping would not detect the 
delay. This happened because ping writes to the ICMP packet the 
timestamp when it is first received by the kernel, before netfilter 
hooks. Using ping with the old behavior (ping -U) worked as expected, 
printing the time the packet was kept in my netfilter hook.

Thanks,

-- 
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

