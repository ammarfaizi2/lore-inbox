Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSJVGAr>; Tue, 22 Oct 2002 02:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbSJVGAr>; Tue, 22 Oct 2002 02:00:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16174 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262235AbSJVGAr>; Tue, 22 Oct 2002 02:00:47 -0400
To: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 00:04:59 -0600
In-Reply-To: <m13cqzumx3.fsf@frodo.biederman.org>
Message-ID: <m1ptu3t3ec.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Digging further into the one failure I can reproduced, I have
found a very weird failure case.  The kernel code dies after switching
into 32bit mode.  I found this boot setting the setup.S hooks and printing
a character to the serial port whenever they were encountered.

I will release another version of kexec-tools shortly with a -debug switch
to enable this debugging, and anything else I can think of.  For the most
part I have avoided printing messages out the serial port because not
everyone has one, or has it setup as a serial console.

But if I enable it just on a debugging switch it should be o.k. and help
quite a bit with figuring out why some machines fail, and others do not.

Eric
