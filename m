Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVAQKG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVAQKG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVAQKG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:06:57 -0500
Received: from ranger.systems.pipex.net ([62.241.162.32]:54473 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262191AbVAQKGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:06:44 -0500
Date: Mon, 17 Jan 2005 10:07:36 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [2.6 patch] x8664_ksyms.c: unexport register_die_notifier
In-Reply-To: <1105955659.6304.62.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0501171006100.4644@ezer.homenet>
References: <20050116074649.GW4274@stusta.de>  <20050117092654.GB29270@wotan.suse.de>
 <1105955659.6304.62.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Arjan van de Ven wrote:

> On Mon, 2005-01-17 at 10:26 +0100, Andi Kleen wrote:
>> On Sun, Jan 16, 2005 at 08:46:49AM +0100, Adrian Bunk wrote:
>>> The only user of register_die_notifier (kernel/kprobes.c) can't be
>>> built modular. Therefore, it's the EXPORT_SYMBOL is superfluous.
>>
>> Please don't apply this, it was especially intended for modular debuggers.
>> There is already a hacvked kdb around that uses it.
>
> eh didn't Tigran just mail lkml claiming that kdb and x86-64 really
> don't mix ??

No, I emailed saying that kdb on x86_64 does NOT show the values of 
parameters passed to functions in the backtrace. And, ok, it has some 
other bugs (e.g. reboot doesn't work on SMP) too. But generally speaking 
kdb does work on x86_64. It just still has bugs, but so does every piece 
of software. We should just fix them all, that's all :)

Kind regards
Tigran
