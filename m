Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTIEIPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTIEIPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:15:47 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:3459 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262349AbTIEIPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:15:34 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 5 Sep 2003 01:12:32 -0700 (PDT)
Subject: Re: serial console on x86
In-Reply-To: <1062700460.16972.9.camel@tweedy.ksc.nasa.gov>
Message-ID: <Pine.LNX.4.44.0309050109110.19320-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Bob Chiodini wrote:

>
> On Thu, 2003-09-04 at 12:45, David Lang wrote:
> > I am attempting to install linux (debian 3 based) on some dual athlon
> > boxes with no video card. The BIOS does include serial console
> > capabilities
> >
> > once the system is installed I have no problem booting from the hard
> > drive, but when I attempt to boot from a CD to install (ISOLINUX custom
> > boot disk) I see the lilo prompt, the loading kernel message, the loading
> > initrd.gz message and then it prints 'Ready.' and reboots the same
> > bootdisk will work just fine if I install a video card in the machine (and
> > the same kernel with lilo boots just fine without a video card after it
> > gets installed)
> >
> > any ideas why the kernel may crash before printing any messages in this
> > situation? I've tried this with 2.4.17 and 2.4.22 with the exact same
> > results.
> >
> > David Lang
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> David,
>
> Do you have a SERIAL directive in your syslinux.cfg (or ISOLINUX
> equivalent) file on the boot CD?
>
> Per the Syslinux readme.doc:
>
>
> SERIAL port [[baudrate] flowcontrol]
>
> I have been using:
>
> serial 0 38400 0x003
>
> on an embedded system, booting from either a CompactFlash or
> DiskOnChip.
>
> My flowcontrol parm is:
>
> 0x001 - Assert DTR + 0x002 - Assert RTS for a NULL modem cable.
>
> The port number corresponds to ports detected by the BIOS.
>
I haven't tried the serial directive yet (in the past I've been able to
get things to work with just the console=ttyS0 on the append line)

I'll give this a try tomorrow.

David Lang
