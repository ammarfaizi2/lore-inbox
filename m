Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbRACRMi>; Wed, 3 Jan 2001 12:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRACRM3>; Wed, 3 Jan 2001 12:12:29 -0500
Received: from dsl-206.169.4.82.wenet.com ([206.169.4.82]:46865 "EHLO
	phobos.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S132558AbRACRMK>; Wed, 3 Jan 2001 12:12:10 -0500
Date: Wed, 3 Jan 2001 08:42:24 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Daniel Phillips <phillips@innominate.de>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A5352ED.A263672D@innominate.de>
Message-ID: <Pine.LNX.4.20.0101030838350.13243-100000@phobos.illtel.denver.co.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Daniel Phillips wrote:

> I don't doubt that if the 'power switch' method of shutdown becomes
> popular we will discover some applications that have windows where they
> can be hurt by sudden shutdown, even will full filesystem data state
> being preserved.  Such applications are arguably broken because they
> will behave badly in the event of accidental shutdown anyway, and we
> should fix them.  Well-designed applications are explicitly 'serially
> reuseable', in other words, you can interrupt at any point and start
> again from the beginning with valid and expected results.

  I strongly disagree. All valid ways to shut down the system involve
sending SIGTERM to running applications -- only broken ones would
live long enough after that to be killed by subsequent SIGKILL.

  A lot of applications always rely on their file i/o being done in some
manner that has atomic (from the application's point of view) operations
other than system calls -- heck, even make(1) does that.

-- 
Alex

----------------------------------------------------------------------
 Excellent.. now give users the option to cut your hair you hippie!
                                                  -- Anonymous Coward

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
