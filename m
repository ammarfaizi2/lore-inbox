Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSIHNs0>; Sun, 8 Sep 2002 09:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSIHNs0>; Sun, 8 Sep 2002 09:48:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318774AbSIHNsZ>;
	Sun, 8 Sep 2002 09:48:25 -0400
Date: Sun, 8 Sep 2002 14:53:06 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Joe Kellner <jdk@kingsmeadefarm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: clean before or after dep?
Message-ID: <20020908135306.GB701@gallifrey>
References: <Pine.LNX.4.44.0209072139470.21724-100000@redshift.mimosa.com> <1031490782.26902.4.camel@irongate.swansea.linux.org.uk> <1031491886.3d7b512ec36fc@webmail.kingsmeadefarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031491886.3d7b512ec36fc@webmail.kingsmeadefarm.com>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 14:50:45 up 1 day,  2:35,  1 user,  load average: 2.01, 2.03, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joe Kellner (jdk@kingsmeadefarm.com) wrote:

> Currently, what is the proper way then? I know over the years the proper 
> procedure has changed. make *config; make dep; make clean; make *Image;make 
> modules?

I always do

make clean && make dep && make ......

Notes:
  1) I've always done clean and then dep ever since a problem on Alpha
	where it created a file during dep and deleted it in clean.

	2) I always use && instead of ;  - that way if one of the stages fails
	you don't miss it.

	3) The ..... - some architectures like zImage, some like Image, some
	like boot; hell I can never remember which a particular platform
	needs.  I wish we had some commonality (hmm - an 'itso' target).

	4) Generally make {menu|x}config tells you the story for x86 at the
	end.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
