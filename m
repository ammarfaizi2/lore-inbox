Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWAZTDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWAZTDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWAZTDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:03:00 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:63006 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964810AbWAZTC7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:02:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iNY3ChACJq4NaJALH/oWmhAOMxuBb/tITfJfcpp1HfQ3DUk5KQxigSvzlG9oE42mAV7FelQ/4RicgQ/Rnvzfa9nDxVzxBJbTQbfxWp71Xy9PDKq1NvSW2hS8iy6P+PZ1SQKY5a6MKbRNrUWHIrfSxjvzxxai7qFgE/Ji8RNdoBs=
Message-ID: <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
Date: Thu, 26 Jan 2006 20:02:56 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.16-rc1-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D7A047.3070004@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
	 <43D7A047.3070004@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/01/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Hi,
>
> Michal Piotrowski wrote:
> > ------------[ cut here ]------------
> > kernel BUG at /usr/src/linux-mm/include/linux/mm.h:302!
> > invalid opcode: 0000 [#1]
> > PREEMPT SMP DEBUG_PAGEALLOC
> > last sysfs file: /class/vc/vcsa7/dev
> > Modules linked in: binfmt_misc thermal fan processor ipv6 w83627hf
> > hwmon_vid hwmon i2c_isa snd_intel8x0 snd_ac97_codec snd_ac97_bus
> > sk98lin snd_pcm_oss snd_mixer_oss skge intel_agp snd_pcm snd_timer snd
> > soundcore i2c_i801 parport_pc parport snd_page_alloc 8250_pnp 8250
> > serial_core agpgart rtc ide_cd cdrom hw_random unix
> > CPU:    0
> > EIP:    0060:[<b013fe81>]    Not tainted VLI
> > EFLAGS: 00210246   (2.6.16-rc1-mm3 #1)
> > EIP is at release_pages+0x33/0x15e
>
> Is it repeatable?
>
> If so, I'd imagine it must be a specific driver page which is not properly
> refcounted somewhere. A bug in generic code would have shown up elsewhere
> by now.
>
> Can you try something like the attached patch and see what it gives you?
>
> Thanks,
> Nick
>
> --
> SUSE Labs, Novell Inc.

[snip]


Here is dmesg:
http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-dmesg
Here is config:
http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-config

I hope it helps.

Regards,
Michal Piotrowski
