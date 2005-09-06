Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVIFUhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVIFUhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVIFUhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:37:06 -0400
Received: from ns1.coraid.com ([65.14.39.133]:12534 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750861AbVIFUhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:37:05 -0400
To: Jim MacBaine <jmacbaine@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: aoe fails on sparc64
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87vf1mm7fk.fsf@coraid.com>
	<20050831.232430.50551657.davem@davemloft.net>
	<87k6i0bnyn.fsf@coraid.com>
	<3afbacad05090309064b3cad87@mail.gmail.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Tue, 06 Sep 2005 16:31:19 -0400
In-Reply-To: <3afbacad05090309064b3cad87@mail.gmail.com> (Jim MacBaine's
 message of "Sat, 3 Sep 2005 18:06:33 +0200")
Message-ID: <87ll2agcq0.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim MacBaine <jmacbaine@gmail.com> writes:

> On 9/1/05, Ed L Cashin <ecashin@coraid.com> wrote:
>
>> The aoe driver looks OK, but it turns out there's a byte swapping bug
>> in the vblade that could be related if he's running the vblade on a
>> big endian host (even though he said it was an x86 host), but I
>> haven't heard back from the original poster yet.
>
> It is in fact a x86_64 kernel, but with a mostly x86 userland. Vblade
> is pure x86 code.
>
>> The vblade bug was the omission of swapping the bytes in each short.
>> The fix below shows what I mean:
>
> Unfortunately it doesn't fix anything here. The client still reports
> the same wrong size as before.  The dmesg output is identical, too.

Let's take this discussion off the lkml, because I doubt there's a
problem with the aoe driver in the kernel, and I can easily follow up
to the lkml with a synopsis if it turns out I'm wrong.

Jim MacBaine, I'm going to ask for more details in a separate email.

-- 
  Ed L Cashin <ecashin@coraid.com>

