Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWDTU33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWDTU33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWDTU33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:29:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:18608 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751243AbWDTU33 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:29:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RatgMUyeJup93t6050GQbFzdvbg06BsZb11ZfiLR9iUPzTliJsrAY61bnqhZ1UEO60VlF2k3WjtWs5z6/jfr6qTKkmWN36QmjKv1l50LvbtYi9pL8kSNrZfKMdWFWA4Cc/csO0bvOtS2HvlsrFodX+G738aB01DpK2EjlBJMbTI=
Message-ID: <b3be17f30604201329w78b739b2j30c95ad92e75d48d@mail.gmail.com>
Date: Thu, 20 Apr 2006 13:29:28 -0700
From: "Robert Merrill" <grievre@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: NFS bug?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1145560845.8136.26.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
	 <1145551304.8136.5.camel@lade.trondhjem.org>
	 <b3be17f30604200953i652e14a2n908f1a066ffe4e7f@mail.gmail.com>
	 <1145555789.8136.13.camel@lade.trondhjem.org>
	 <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
	 <1145556613.8136.14.camel@lade.trondhjem.org>
	 <b3be17f30604201114n7a50bad9u6f3839a029f571a7@mail.gmail.com>
	 <1145560845.8136.26.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not an oops. It's a BUG_ON.

That was the entire message.

On 4/20/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Thu, 2006-04-20 at 11:14 -0700, Robert Merrill wrote:
> > > Oh... and could you also send us the Oops/stack trace from the BUG_ON()?
> > >
> >  ------------[ cut here ]------------
> > kernel BUG at arch/i386/lib/usercopy.c:582!
> > invalid operand: 0000 [#49]
> > SMP
> > Modules linked in: w83627hf eeprom lm85 w83781d hwmon_vid i2c_isa
> > i2c_dev thermal fan button processor ac battery nfs lockd nfs_acl
> > sunrpc ipv6 quota_v1 ide_cd cdrom generic joydev piix psmouse evdev
> > uhci_hcd ehci_hcd parport_pc parport e1000 rtc serio_raw floppy
> > usbcore i2c_i801 ide_core i2c_core mousedev pcspkr shpchp pci_hotplug
> > CPU:    2
> > EIP:    0060:[<c01ff157>]    Not tainted VLI
> > EFLAGS: 00010282   (2.6.15.7-soda0)
> > EIP is at __copy_from_user_ll+0x12/0xe2
> > eax: 00000000   ebx: 00000003   ecx: fffffffb   edx: fffffffb
> > esi: 0804a024   edi: 00000000   ebp: 00000000   esp: f6964f84
> > ds: 007b   es: 007b   ss: 0068
> > Process a.out (pid: 6994, threadinfo=f6964000 task=f70e7030)
> > Stack: fffffffb b7f55ff4 f893c2a0 00000000 0804a024 fffffffb fffffffb
> 000000d0
> >        f70e7030 00000003 0804a024 b7f55ff4 f6964000 f893dc1d 00000003
> 0804a024
> >        00004000 0804a024 b7f55ff4 bf973d50 ffffffda 0000007b c010007b
> 000000dc
> > Call Trace:
> > Code: 07 29 c8 f3 a4 89 c1 c1 e9 02 83 e0 03 90 f3 a5 89 c1 f3 a4 89
> > c8 5e 5f c3 57 56 8b 7c 24 0c 8b 74 24 10 8b 4c 24 14 85 c9 79 08 <0f>
> > 0b 46 02 63 92 2f c0 83 f9 3f 0f 86 99 00 00 00 89 f8 31 f0
>
> Was there no stack trace in that Oops? AFAICS, getdents64() isn't
> supposed to be calling __copy_from_user_ll() at all, so you appear to
> have something very weird going here.
>
> Cheers,
>   Trond
>
>
