Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271801AbRHRKLe>; Sat, 18 Aug 2001 06:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271803AbRHRKLZ>; Sat, 18 Aug 2001 06:11:25 -0400
Received: from [212.17.128.60] ([212.17.128.60]:1920 "HELO lapper.ihatent.com")
	by vger.kernel.org with SMTP id <S271801AbRHRKLV>;
	Sat, 18 Aug 2001 06:11:21 -0400
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Cc: jason@topic.com.au,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [OT?] Re: [PATCH] patch's for vmware 2.0.4 for use with linux-2.4.8 kernel
In-Reply-To: <3B7D1846.BEB929DE@TeraPort.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Aug 2001 12:09:37 +0200
In-Reply-To: <3B7D1846.BEB929DE@TeraPort.de>
Message-ID: <m3ofpd3cim.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch <Martin.Knoblauch@TeraPort.de> writes:

> > [PATCH] patch's for vmware 2.0.4 for use with linux-2.4.8 kernel
> > 
> > From: Jason Thomas (jason@topic.com.au)
> > Date: Thu Aug 16 2001 - 03:49:38 EST
> > 
> > 
> > attached are two very small patches for those that want them. they make
> > vmware's kernel modules compile with 2.4.8. Its not all my work, its a
> > combination of what was posted a while back and my work.
> > 
> Jason,
> 
>  a small gotcha in your vmmon patch. You moved up hostif.h in driver.c,
> but you forgot to remove the original include. See my attached new
> version of the patch.
> 
> Martin
> -- 

I've applied the patch with your fixes, and I've always noticed that
VMware seem to leak a bit of memory (occording to top and ps). Running
with 128Mb in a Win2k box it started off at 161Mb process size (140Mb
RSS) and within 5 minutes it had turned into 203Mb process size (still
only 140Mb RSS). Have anyone seen similar behavior, and does anyone
have any pointers to where I can find more info on it?

mvh,
A
-- 
Alexander Hoogerhuis
FYI: perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
