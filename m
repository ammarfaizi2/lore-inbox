Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275905AbSIULvu>; Sat, 21 Sep 2002 07:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275906AbSIULvu>; Sat, 21 Sep 2002 07:51:50 -0400
Received: from [195.39.17.254] ([195.39.17.254]:40064 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S275905AbSIULvt>;
	Sat, 21 Sep 2002 07:51:49 -0400
Date: Sat, 21 Sep 2002 13:56:21 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: taka@valinux.co.jp, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20020921115619.GA1000@elf.ucw.cz>
References: <20020918.171431.24608688.taka@valinux.co.jp> <20020918.160057.17194839.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918.160057.17194839.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
>    
>    1)
>    ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va10-hwchecksum-2.5.36.patch
>    This patch enables HW-checksum against outgoing packets including UDP frames.
>    
> Can you explain the TCP parts?  They look very wrong.
> 
> It was discussed long ago that csum_and_copy_from_user() performs
> better than plain copy_from_user() on x86.  I do not remember all
> details, but I do know that using copy_from_user() is not a real
> improvement at least on x86 architecture.

Well, if this is the case, we need to #define copy_from_user csum_and_copy_from_user :-).

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
