Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSHPGFf>; Fri, 16 Aug 2002 02:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSHPGFf>; Fri, 16 Aug 2002 02:05:35 -0400
Received: from mortar.viawest.net ([216.87.64.7]:5803 "EHLO mortar.viawest.net")
	by vger.kernel.org with ESMTP id <S318182AbSHPGFe>;
	Fri, 16 Aug 2002 02:05:34 -0400
Date: Thu, 15 Aug 2002 23:09:25 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Ivan Gyurdiev <ivangurdiev@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Floppies under 2.5.
Message-ID: <20020816060925.GA22648@wizard.com>
References: <200208130907.23127.ivangurdiev@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208130907.23127.ivangurdiev@attbi.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.4.19 (i686)
X-uptime: 11:03pm  up 12 days, 10:02,  2 users,  load average: 0.00, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:07:23AM -0400, Ivan Gyurdiev wrote:
> My floppy refuses to mount under 2.5.31.
> The first attempt leads to segmentation fault.
> The second attempt leads to an unkillable
> (killall -9 mount as root has no effect) process which freezes on the 
> open call:
> 
> stat64("/dev/fd0", {st_mode=S_IFBLK|0660, st_rdev=makedev(2, 0), ...}) = 0
> open("/dev/fd0", O_RDONLY|O_LARGEFILE
> ========================
> 
> Mounting floppies works fine under 2.4.

        Of course it works in 2.4. that's the stable series! ;)

        Seriously, the floppy driver has been broken since 2.5.8, and will 
probably stay that way until someone comes along and fixes it. I believe it's 
being ported over to the new API, but I'm sure Dave or the others will get 
more into that. I last had the floppy working with 2.5.7. If you're expecting
to use the floppy driver to mount any sort of filesystem, expect either 
severe corruption, kernel freezing as you've reported, oops, or any other
thing that has or hasn't been reported, excluding normal ops. Use 2.4 for
mounting floppies.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

