Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVJaXMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVJaXMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVJaXMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:12:38 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:31754 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964885AbVJaXMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:12:38 -0500
Message-ID: <4366A4DE.9020406@rainbow-software.org>
Date: Tue, 01 Nov 2005 00:12:30 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Ray Lee <ray-lk@madrabbit.org>, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it> <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it> <43667406.9070104@gmail.com>
In-Reply-To: <43667406.9070104@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrizio Bassi wrote:

 > Ray Lee ha scritto:
 >
 >> On Mon, 2005-10-31 at 18:04 +0100, Patrizio Bassi wrote:
 >>
 >>
 >>>> On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
 >>>>
 >>>>
 >>>>> starting from 2.6.0 (2 years ago) i have the following bug.
 >>>>> link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
 >>
 >>
 >>
 >>>>> fast summary:
 >>>>> when playing audio and using a bit the harddisk (i.e. md5sum of a 
200mb
 >>>>> file) i hear noises, related to disk activity. more hd is used, 
more chicks
 >>>>> and ZZZZ noises happen.
 >>>>
 >>>>
 >>>> Does hdparm -i (or -I) show differences between the 2.4 kernels and
 >>>> 2.6? 2.6 has new IDE drivers, and so perhaps your system isn't using
 >>>> the best driver any more.
 >>>>
 >>>> You may also want to compare lspci -vv of your IDE controller and
 >>>> sound card between 2.4 and 2.6, and see if there are any differences.
 >>>>
 >>>> No guarantees, but this is where you'd start.
 >>>>
 >>>>
 >>>>
 >>>>
 >>>>> Ready to test any patch/solution.
 >>>>
 >>>>
 >>>>
 >>>> Try that. If nothing obvious appears in the examination, you may want
 >>>> to try the 2.6.14-rt1 patchset from Ingo Molnar. It's designed to
 >>>> reduce latency in the kernel, but also has a latency tracer that may
 >>>> be particularly useful for your problem. (Assuming it's a latency
 >>>> issue, and not a hardware misconfiguration due to 2.6 doing something
 >>>> wrong.)


I've seen something like this yesterday on ECS P6EXP-Me board (i440EX 
chipset) with onboard CMI8338 PCI sound chip. The sound was distorted 
when e.g. moving mouse in Windows. When I disabled "PCI 2.1 support" in 
BIOS, the problem disappeared in Windows. But when I booted Slax LiveCD, 
the same problem appeared - so I think that Linux enables something 
that's causing these problems with some PCI sound devices on these chipsets.

-- 
Ondrej Zary

