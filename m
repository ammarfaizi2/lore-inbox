Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWD1ODa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWD1ODa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWD1ODa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:03:30 -0400
Received: from [195.23.16.24] ([195.23.16.24]:40098 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030411AbWD1OD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:03:29 -0400
Message-ID: <445220AB.9000606@grupopie.com>
Date: Fri, 28 Apr 2006 15:03:23 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
References: <20060427014141.06b88072.akpm@osdl.org>	<p73vesv727b.fsf@bragg.suse.de>	<20060427121930.2c3591e0.akpm@osdl.org>	<200604272126.30683.ak@suse.de>	<20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com>
In-Reply-To: <44512B61.4040000@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
>>[...]
> I don't want to boot it, as that gets into security nightmares, but I 
> should be able to provide something that does static testing.

Actually, booting might not be that bad using a virtual machine with qemu.

You can use a command like:

qemu -nographic -kernel <kernel_image> -append <command line> -initrd 
<initrd file>

and then set up the <command line> to use the serial console, and the 
initrd to something simple that just outputs "[SUCCESS]" and powers off.

You can then monitor the standard output of this process. If after a 
minute (for instance) no "[SUCCESS]" appears on its standard output, it 
didn't boot and you have the dmesg data to (hopefully) show why it 
didn't boot.

If it outputs "[SUCCESS]", then it booted fine. You still can append the 
dmesg output to the test report.

Of course, the kernel configuration must include support for serial 
console and the initrd filesystem used, at least.

Well, just my 2 cents,

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
