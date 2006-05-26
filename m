Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWEZJTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWEZJTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWEZJTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:19:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23209 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751352AbWEZJTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:19:22 -0400
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Gerd Hoffmann" <kraxel@suse.de>, "Magnus Damm" <magnus@valinux.co.jp>,
       "Andrew Morton" <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current
 pgd (V2, x86_64)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044247.14219.13579.sendpatchset@cherry.local>
	<m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	<1148545616.5793.180.camel@localhost> <4476B0F6.2000708@suse.de>
	<aec7e5c30605260202m531b0f01pfd244932d9fc99a9@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 26 May 2006 03:18:15 -0600
In-Reply-To: <aec7e5c30605260202m531b0f01pfd244932d9fc99a9@mail.gmail.com> (Magnus
 Damm's message of "Fri, 26 May 2006 18:02:19 +0900")
Message-ID: <m1r72hb0vc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 5/26/06, Gerd Hoffmann <kraxel@suse.de> wrote:
>> > 1a. The C-code in xen_machine_kexec() performs a hypercall.
>> >
>> > 1b. The hypervisor jumps to the assembly code.
>> > After prepare we've created a NX-safe mapping for the control page. We
>> > jump to that NX-safe address to transfer control to the assembly code.
>>
>> This is about kexec'ing the physical machine, not the virtual machine,
>> right?
>
> Correct, kexec:ing from dom0.

And staying in dom0?  Or does Xen go away?

Eric
