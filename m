Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSJVXZs>; Tue, 22 Oct 2002 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSJVXZs>; Tue, 22 Oct 2002 19:25:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262604AbSJVXZq>;
	Tue, 22 Oct 2002 19:25:46 -0400
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
From: Andy Pfiffer <andyp@osdl.org>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
In-Reply-To: <1035329239.24994.58.camel@andyp>
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
	<m1ptu3t3ec.fsf@frodo.biederman.org>  <m1fzuyub3z.fsf@frodo.biederman.org> 
	<1035329239.24994.58.camel@andyp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Oct 2002 16:32:22 -0700
Message-Id: <1035329542.29319.60.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 16:27, Andy Pfiffer wrote:
> On Tue, 2002-10-22 at 01:33, Eric W. Biederman wrote:
> > Ok as promised kexec-tools-1.3.tar.gz is released.
> > 
> > The new test case it provides is
> > kexec -debug bzImage
> > 
> > The serial console must be initialized before using this.
> > 
> > [root@p4dp8-0 root]# kexec -debug bzImage-2.4.17.eb-amd768-eepro100-kexec-apic-lb-mtd2 ip=dhcp root=/dev/nfs console=tty0 console=ttyS0,9600 reboot=hard panic=5 ide0=ata66 verbose
> > setup16_end: 00091ac4
> > Shutting down devices
> > kexecing image
> > a
> > b
> > c
> > d
> > e
> > f
> > g
> > h
> > < All above are various points in x86-setup-16.S >
> > i < Printed from the first callback in setup.S, before protected mode is entered >
> > j < Printed from the second callback in setup.S, just before the kernel decompresser is run >
> 
> 
> joe:/boot # ./kexec-1.3 -debug linux-2.5 console=ttyS0,9600 reboot=hard
> verbose
> setup16_end: 00091a94
> kexecing image
> a
> b
> c
> d
> e
> f
> g
> h
> 
> Wedged.

Same results for the 2.4.18-based kernel:
joe:/boot # ./kexec-1.3 -debug linux-cgle console=ttyS0,9600 reboot=hard
setup16_end: 00091084
kexecing image
a
b
c
d
e
f
g
h

Wedged.

Andy


