Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270537AbRHHR6F>; Wed, 8 Aug 2001 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270540AbRHHR5y>; Wed, 8 Aug 2001 13:57:54 -0400
Received: from [216.151.155.121] ([216.151.155.121]:58125 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S270537AbRHHR5o>; Wed, 8 Aug 2001 13:57:44 -0400
To: "Rob" <rwideman@austin.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: configuring the kernel
In-Reply-To: <LHEGJICMMCCGOHKDFALMOEMHCAAA.rwideman@austin.rr.com>
From: Doug McNaught <doug@wireboard.com>
Date: 08 Aug 2001 13:56:28 -0400
In-Reply-To: "Rob"'s message of "Wed, 8 Aug 2001 12:11:44 -0500"
Message-ID: <m3n15aigfn.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rob" <rwideman@austin.rr.com> writes:

> 1-does "make menuconfig" require X to be installed? I dont have X, i just
> have RH 7.1 with kernel dev and kernel sources installed (atleast those were
> the ONLY things i had selected during install).

No, all you need is the 'ncurses-devel' package.  

> 2-if i untared/unpacked the kernel to the folder /root/newkern (here is
> where i did the "gzip -cd linux 2.4.7...... |tar xvf -" command) is it ok to
> delete the newkern folder and unpack nd then do the "make menuconfig"?

Yes, but this will reset your configuration to the defaults.  If you
want to preserve the choices you made and then modify them in
menuconfig, save off the '.config' file before nuking, then move it
into the newly unpacked directory.

That said, you shouldn't have to remove the source tree.  Simply do:

$ make menuconfig
$ make dep && make clean && make bzImage

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
