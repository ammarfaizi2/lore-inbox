Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSJVI2x>; Tue, 22 Oct 2002 04:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJVI2x>; Tue, 22 Oct 2002 04:28:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30254 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262296AbSJVI2w>; Tue, 22 Oct 2002 04:28:52 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
	<m1ptu3t3ec.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 02:33:04 -0600
In-Reply-To: <m1ptu3t3ec.fsf@frodo.biederman.org>
Message-ID: <m1fzuyub3z.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok as promised kexec-tools-1.3.tar.gz is released.

The new test case it provides is
kexec -debug bzImage

The serial console must be initialized before using this.

[root@p4dp8-0 root]# kexec -debug bzImage-2.4.17.eb-amd768-eepro100-kexec-apic-lb-mtd2 ip=dhcp root=/dev/nfs console=tty0 console=ttyS0,9600 reboot=hard panic=5 ide0=ata66 verbose
setup16_end: 00091ac4
Shutting down devices
kexecing image
a
b
c
d
e
f
g
h
< All above are various points in x86-setup-16.S >
i < Printed from the first callback in setup.S, before protected mode is entered >
j < Printed from the second callback in setup.S, just before the kernel decompresser is run >


I have a very strange node that makes it all of the way to 'j' before rebooting.
The concept that something is dying in protected mode will all of the interrupts
disabled is so novel that I really don't know what to make of it, yet.

But I would be very interested if other people had similar experiences. 

Eric


