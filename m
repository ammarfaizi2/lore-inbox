Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbSIXKeM>; Tue, 24 Sep 2002 06:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSIXKeM>; Tue, 24 Sep 2002 06:34:12 -0400
Received: from unthought.net ([212.97.129.24]:21996 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261639AbSIXKeL>;
	Tue, 24 Sep 2002 06:34:11 -0400
Date: Tue, 24 Sep 2002 12:39:24 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924103923.GI2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net> <20020924134816.A23185@namesys.com> <20020924100338.GH2442@unthought.net> <20020924142521.C23185@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020924142521.C23185@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:25:21PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Tue, Sep 24, 2002 at 12:03:38PM +0200, Jakob Oestergaard wrote:
> 
> > It's a question of which errors one wishes to handle, and which you
> > simply choose to ignore.
> 
> Yes, that's true. Reiserfs chose to not handle any HW errors, this is even
> written somewhere in our FAQ.

Fair enough.

...
> Ok, I did.
> You math was wrong, you forgot to account that your number should be divided
> by 128, not 512, since integer itself is 4 bytes long on x86.
> (See message from Itai Nahshon <nahshon@actcom.co.il>, August 7th
> Message-Id: <200208071443.30551.nahshon@actcom.co.il> if you missed that originally.)

Darn !

Thanks for pointing that one out - I missed it.

And you (well nahson@atcom.co.il) is right and I am wrong.

...
> Probably I mssed that part of converstion, then.
> As I see the IDE thing, you tell the hardware that you want to write some amount
> of _sectors_ to the hard drive, and then feed the controller with necessary
> amount of data. If it writes these sectors from the start of the data flow,
> what will it do on data transefer timeout?
> So I still think that data is written on disk in 512 bytes atomic blocks
> until I see IDE device that does otherwise (and then I will probably
> dig some IDE datasheet and find out they are violating some spec ;) )

That would be really interesting.

I mean, my point still stands even though my proof was wrong, unless
someone can come up with a "proof" (a spec would be close enough) that
writes must be 512 bytes.

Thanks,   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
