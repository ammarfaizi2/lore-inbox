Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285024AbRLTG6n>; Thu, 20 Dec 2001 01:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286186AbRLTG6d>; Thu, 20 Dec 2001 01:58:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38930 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285024AbRLTG6V>; Thu, 20 Dec 2001 01:58:21 -0500
Message-ID: <3C218BF3.6010603@zytor.com>
Date: Wed, 19 Dec 2001 22:57:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>	<m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com>	<m1zo4fursh.fsf@frodo.biederman.org>	<9vrlef$mat$1@cesium.transmeta.com> <m1r8pqv1w3.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
>>Followup to:  <m1zo4fursh.fsf@frodo.biederman.org>
>>By author:    ebiederm@xmission.com (Eric W. Biederman)
>>In newsgroup: linux.dev.kernel
>>
>>>Which just goes to show what a fragile firmware design it is, to have
>>>firmware callbacks doing device I/O.  I think the whole approach of
>>>having firmware callbacks is fundamentally flawed but I'll do my best
>>>to keep it working, for those things that care.  If it works over 50%
>>>of the time I'm happy...
>>>
>>>
>>NAK.  You can make it perfectly robust thankyouverymuch, as long as
>>you don't try to *mix* firmware and poking directly at the
>>hardware... this is a classic "who owns what" class problem.
>>
> 
> I agree that I could keep it working as well as it ever would.  Not
> that x86 firmware or any software is ever perfectly working.
> 


True enough; I guess what I meant is you can design it so that it is *no 
less unreliable than the underlying firmware*.


> At this point in time I live in a world where 99+% of the time the
> hardware is owned by the operating system, and the firmware is just
> there to get the operating system loaded, and to hold details about
> the motherboard that the operating system can not find out by probing
> the hardware.


Right.  My point was that you want to treat the transition as modal -- 
you have "boot mode" and you have "runtime".  My work was to build a 
Linux kernel derivative which could run in "boot mode" and therefore not 
require drivers.  The intent was that this "boot mode" kernel would then 
load the real "runtime" kernel and transition to it.

My comment was mostly that there is a persistent myth that you can't use 
the x86 firmware from protected mode.  You can't, directly, but you can 
get the functionality through other means.  This is hardly a new 
technique; in fact, it's very similar to the DOS extenders of old times; 
in fact, it's somewhat simpler.

	-hpa


