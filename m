Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131107AbRCGQM7>; Wed, 7 Mar 2001 11:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRCGQMt>; Wed, 7 Mar 2001 11:12:49 -0500
Received: from mail.zmailer.org ([194.252.70.162]:57358 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131104AbRCGQMl>;
	Wed, 7 Mar 2001 11:12:41 -0500
Date: Wed, 7 Mar 2001 18:12:27 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver
Message-ID: <20010307181227.H23336@mea-ext.zmailer.org>
In-Reply-To: <200103071442.PAA14348@ns.caldera.de> <200103071529.f27FTjO26978@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200103071529.f27FTjO26978@aslan.scsiguy.com>; from gibbs@scsiguy.com on Wed, Mar 07, 2001 at 08:29:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 08:29:45AM -0700, Justin T. Gibbs wrote:
> >What about simply removing the firmware source and assembler from the
> >kernel tree?  We have lots of firmware in the kernel tree for which
> >there isn't even firmware  avaible...
> 
> What, and not allow others to fix my bugs for me? :-)
> 
> Lots of people have embedded this driver just because it is completely
> open source.  I'd like to have all distributions be "complete"
> distributions.

	I presume the aicasm (or whatever) can do its meager DB needs
	by simpler ubiquitous things like  GDBM.   SleepyCat DBx is good,
	but in this case as serious overkill as e.g. using Oracle ;)
	(No, I didn't read the source of the aicasm.)

	There really should be some convenient way to compile the firmware
	from source when wanted, but the normal case should not be dependent
	of FIRMWARE SOURCE - the integer/byte array include file should
	be enough for normal users.

		$ (cd drivers/xx/yy; make aic7xxx.fw )

	What HOSTCC et.al. settings are needed, that I can't say,
	and that 'make' method doesn't get top-level definitions in...

	Simultaneously (as 'aic7xxx.fw' would not be the real filename),
	aic7xxx.o file's dependencies would contain the real firmware
	files so that "make bzImage" will recompile it correctly.

	When people like Justin are sending the driver update to Linus,
	they just need to be carefull at sending all relevant files/diffs.

	We are placing a lot of trust to these firmware makers to supply
	us working firmware, why not trust them to do it right so that
	compiling kernel won't need to generate firmware assembler program
	at first...


> --
> Justin

/Matti Aarnio
