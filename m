Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJVIYO>; Tue, 22 Oct 2002 04:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJVIYO>; Tue, 22 Oct 2002 04:24:14 -0400
Received: from almesberger.net ([63.105.73.239]:36358 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262303AbSJVIYN>; Tue, 22 Oct 2002 04:24:13 -0400
Date: Tue, 22 Oct 2002 05:30:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
Message-ID: <20021022053005.F1421@almesberger.net>
References: <m1k7kfzffk.fsf@frodo.biederman.org> <1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13cqzumx3.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Oct 21, 2002 at 10:18:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Oh, wait as I recall bootimg simply copies the BIOS results
> from the current kernel to the freshly booted kernel, so it skips
> the BIOS calls altogether.

Yes, I don't trust the BIOS very much under normal conditions,
so I wouldn't even dream of running it with a largely undefined
system state. I'm actually quite surprised that kexec has so
few problems doing that :-)

In any case, since the kexec kernel code is more or less just a
generic loader, this is something you can always decide to
change in user space. The only thing bootimg did that kexec
doesn't do is to explicitly mark BIOS-provided data tables
(mainly SMP stuff) as reserved so that they won't be
overwritten. But it seems that mpparse.c now reserves that
already, so kexec should be fine.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
