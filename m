Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTD2MPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTD2MPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:15:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:61908 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261842AbTD2MPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:15:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: tobias@stud.cs.uit.no
Subject: Re: PROBLEM: nfsroot.c + ipconfig.c (2.4.20)
Date: Tue, 29 Apr 2003 14:28:03 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200304231510.h3NFAh430564@lgserv3.stud.cs.uit.no> <shs8yu1uqak.fsf@charged.uio.no> <20030426123356.C12540@stud.cs.uit.no>
In-Reply-To: <20030426123356.C12540@stud.cs.uit.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304291428.03465.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cutted Trond, since he's surely busy with more important things]

On Saturday 26 April 2003 12:33, Tobias Brox wrote:

> with harddisks.  I'd like to hear success-stories from people that
> have managed to do a diskless boot with a kernel of version 2.4.20 or
> more recent.

No problem here with 2.4.20, 2.5.any not yet tested. I'm doing diskless 
since ages, but my setup seems to vary from yours. In short, I'm using 
etherboot, tftp and mknbi. E.g.:

mknbi-linux $kernelimg $ramdisk --rootdir="/netboot/%s,v3" --ip=rom \ 
--append="$append"

%s gets replaced by the loader with the systems ip address. It refers to 
a symbolic link, which is pointing to the real root dir.

I'm able to boot standard distri (install-) kernels (SuSE) this way, 
which makes updating a hitch, through I prefer to run my home rolled.

Mangling a standard distri to run diskless is a bit of a hassle, but no
real problem either.

Cheers,
Pete
