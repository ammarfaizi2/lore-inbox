Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTALWSU>; Sun, 12 Jan 2003 17:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267562AbTALWSU>; Sun, 12 Jan 2003 17:18:20 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:5070 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267560AbTALWSS>; Sun, 12 Jan 2003 17:18:18 -0500
Date: Sun, 12 Jan 2003 17:22:25 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <200301122306.14411.oliver@neukum.name>
To: Oliver Neukum <oliver@neukum.name>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042410145.3162.152.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <200301122306.14411.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:06, Oliver Neukum wrote:
> Please don't do such things. The next time locking is changed and a lock
> is needed here, some poor guy has to go through that and change all
> back to goto.
> This may not be applicable here, but as a general rule, don't do it.
> I speak from experience.
> 
> As for efficiency, that is the compiler's job.

I say "please don't use goto" and instead have a "cleanup_lock" function
and add that before all the return statements..  It should not be a
burden.  Yes, it's asking the developer to work a little harder, but the
end result is better code.

-Rob

