Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTALW3G>; Sun, 12 Jan 2003 17:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbTALW3F>; Sun, 12 Jan 2003 17:29:05 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:4843 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267573AbTALW2z>; Sun, 12 Jan 2003 17:28:55 -0500
Date: Sun, 12 Jan 2003 17:35:44 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <20030112221849.GO31238@vitelus.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Oliver Neukum <oliver@neukum.name>, Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042410944.1208.168.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
 <200301122312.41879.oliver@neukum.name> <20030112221849.GO31238@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:18, Aaron Lehmann wrote:
> On Sun, Jan 12, 2003 at 11:12:41PM +0100, Oliver Neukum wrote:
> > Yes. Typical error cleanup looks like:
> > err_out:
> > 	up(&sem);
> > 	return err;
> > 
> > Releasing a lock in another function is a crime punished by slow death.
> 
> Not to mention that the 'return err;' statement is hard to move to an
> inline function meaningfully.

Not that hard:  You just "return functionname()" where functionname is
the name of your inline function that returns the value you want to
return.

-Rob

