Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbTALVhO>; Sun, 12 Jan 2003 16:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTALVhO>; Sun, 12 Jan 2003 16:37:14 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:5259 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267536AbTALVhN>; Sun, 12 Jan 2003 16:37:13 -0500
Date: Sun, 12 Jan 2003 16:44:05 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 16:40, Rik van Riel wrote:
> OK, now imagine the dcache locking changing a little bit.
> You need to update this piece of (duplicated) code in half
> a dozen places in just this function and no doubt in dozens
> of other places all over fs/*.c.
> 
> >From a maintenance point of view, a goto to a single block
> of error handling code is easier to maintain.
> 

There's no reason, though, that the error handling/cleanup code can't be
in an entirely separate function, and if speed is needed, there's no
reason it can't be an "inline" function.  Or am I oversimplifying things
again?

-Rob

