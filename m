Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129698AbQKHDk6>; Tue, 7 Nov 2000 22:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129559AbQKHDks>; Tue, 7 Nov 2000 22:40:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:1288 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129414AbQKHDkf>; Tue, 7 Nov 2000 22:40:35 -0500
Date: Tue, 7 Nov 2000 21:36:42 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
Message-ID: <20001107213642.A8542@vger.timpanogas.org>
In-Reply-To: <3A089254.397115FE@timpanogas.org> <Pine.LNX.4.21.0011080322350.8632-100000@neo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011080322350.8632-100000@neo.local>; from davej@suse.de on Wed, Nov 08, 2000 at 03:25:56AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 03:25:56AM +0000, davej@suse.de wrote:
> On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> 
> > If the compiler always aligned all functions and data on 16 byte
> > boundries (NetWare)  for all i386 code, it would run a lot faster.
> 
> Except on architectures where 16 byte alignment isn't optimal.
> 
> > Cache line alignment could be an option in the loader .... after all,
> > it's hte loader that locates data in memory.  If Linux were PE based,
> > relocation logic would be a snap with this model (like NT).
> 
> Are you suggesting multiple files of differing alignments packed into
> a single kernel image, and have the loader select the correct one at
> runtime ? I really hope I've misinterpreted your intention.

Or more practically, a smart loader than could select a kernel image
based on arch and auto-detect to load the correct image. I don't really
think it matters much what mechanism is used.   

What makes more sense is to pack multiple segments for different 
processor architecures into a single executable package, and have the 
loader pick the right one (the NT model).  It could be used for 
SMP and non-SMP images, though, as well as i386, i586, i686, etc.  

Jeff

> 
> regards,
> 
> Davej.
> 
> -- 
> | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> | SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
