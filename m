Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289583AbSAOOGA>; Tue, 15 Jan 2002 09:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289585AbSAOOFv>; Tue, 15 Jan 2002 09:05:51 -0500
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:21416 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S289583AbSAOOFn>; Tue, 15 Jan 2002 09:05:43 -0500
Date: Tue, 15 Jan 2002 15:05:37 +0100 (CET)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: How can a SIGKILL'ed process make progress?
Message-ID: <Pine.LNX.4.31.0201151456050.26435-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

Selling the drive to a friend I did a 'time dd if=/dev/zero of=/dev/hdc &'
to erase it. Just out of curiosity I started 'fdisk -l /dev/hdc' while the
dd was going on. As expected this told me there was no valid partition
table, but then stopped in D state. I sent it a SIGKILL, started top and
was a bit puzzled: fdisk was running from time to time and consuming an
average of 5% CPU time. The SIGKILL actually happened only after the the
dd was finished. Is this the expected behaviour for kernel 2.2.18 (SuSE
7.1 boot CD)? My understanding was that fdisk should be hit by SIGKILL the
next time it gets a time slice...

TIA,
					Roland

main(int k,char**p){char*q=p[2];float i,j,r,x,y,a=*q++/4;for(y=a;--y>-
a;puts(""))for(x=0;x++<*q;putchar(p[1][k%9]))for(i=k=r=0;j=r*r-i*i+(x/
*q*q[2]-q[1])/40,i=2*r*i+y/q[3],j*j+i*i<11&&++k<99;r=j);}


