Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310252AbSCSHBl>; Tue, 19 Mar 2002 02:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310259AbSCSHBb>; Tue, 19 Mar 2002 02:01:31 -0500
Received: from daimi.au.dk ([130.225.16.1]:54789 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S310252AbSCSHBU>;
	Tue, 19 Mar 2002 02:01:20 -0500
Message-ID: <3C96E23B.560A6779@daimi.au.dk>
Date: Tue, 19 Mar 2002 08:01:15 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
In-Reply-To: <fa.fu00kkv.1b3a6a4@ifi.uio.no> <fa.mfr7rqv.k42rjk@ifi.uio.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 13 Mar 2002, Brian Gerst wrote:
> 
> > Seperates msdos_sb_info from struct super_block for msdos and vfat.
> > Umsdos is terminally broken and is not included.
> 
> We have everything needed to fix^Wrewrite umsdos and I hope to do that
> this week.

While we are at it I have an idea that might make sense. On recent
kernels I don't see as much reason for umsdos' pseudoroot feature as
in earlier kernels. The same effect could be achieved by using
bindmounts and/or pivot_root. So IMHO it would be neat if umsdos just
setup the two mounts instead of using it's own implementation.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
