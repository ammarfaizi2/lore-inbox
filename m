Return-Path: <linux-kernel-owner+w=401wt.eu-S1755006AbWL1Vqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbWL1Vqd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWL1Vqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:46:33 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:36952 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbWL1Vqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:46:32 -0500
Message-ID: <45943AE4.6080704@gmail.com>
Date: Thu, 28 Dec 2006 22:45:08 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Rene Herman <rene.herman@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
References: <4592E685.5000602@gmail.com> <20061228191204.GB8940@redhat.com>
In-Reply-To: <20061228191204.GB8940@redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Wed, Dec 27, 2006 at 10:32:53PM +0100, Rene Herman wrote:

>> The bug where the kernel repetitively emits "atkbd.c: Spurious ACK
>> on isa0060/serio0. Some program might be trying access hardware
>> directly" (sic) on a panic, thereby scrolling away the information
>> that would help in seeing what exactly the problem was (ie, "Unable
>> to mount root fs" or something) is still present in 2.6.20-rc2.
> 
> Do you have a KVM ?  Quite a few of those seem to tickle this printk.

No, regular old PS/2 keyboard, directly connected. Due to that exact 
uneventfullness and having seen it reported before recently (*) I 
assumed everyone was seeing this. If not, I guess I can try to narrow it 
down.

It's easy to test for anyone willing: just boot with "root=/dev/null" or 
something as a kernel param. The printk's are in sync with the panic 
code blinking the leds.

(*) Here there was supposed to be a link to the post I was refferring 
to, but googling for it led to http://lkml.org/lkml/2006/11/13/300

Dmitry, could you ask Linus to pull the change? I find this to be an 
exceedingly annoying bug. It's just so incredibly silly, having one part 
of the kernel helpfully blink leds at you with another part going "hey, 
dude! don't do that!"

Rene.
