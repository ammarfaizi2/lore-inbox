Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbRACTZC>; Wed, 3 Jan 2001 14:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRACTYw>; Wed, 3 Jan 2001 14:24:52 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:26377 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S130204AbRACTYk>; Wed, 3 Jan 2001 14:24:40 -0500
Date: Wed, 3 Jan 2001 18:52:31 +0000 (GMT)
From: "Dr. David Gilbert" <gilbertd@treblig.org>
To: Daniel Phillips <phillips@innominate.de>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A5352ED.A263672D@innominate.de>
Message-ID: <Pine.LNX.4.30.0101031847120.11227-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Daniel Phillips wrote:

> Tux2 is explicitly designed to legitimize pulling the plug as a valid
> way of shutting down.

Hmm - that IMHO is a good thing; I'll have to look at Tux2.

>  Metadata-only journalling filesystems are not
> designed to be used this way, and even with full-data journalling you
> should bear in mind that your on-disk filesystem image remains in an
> invalid state until the journal recovery program has run successfully.
> You would not want to upgrade your OS with your filesystem in this
> state, nor would you want to remove a disk drive that didn't have the
> journal file on it.

Sure.

> Being able to shut down by hitting the power switch is a little luxury
> for which I've been willing to invest more than a year of my life to
> attain.  Clueless newbies don't know why it should be any other way, and
> it's essential for embedded devices.

Clueless newbies (and slightly less clueless less newbie) type people
don't think that they should HAVE to. My two interests are coping with
particularly pedantic people who don't want there computer to hastle them
about what they should or shouldn't do, and slightly embedded systems
(e.g. set top box/web browsery thing that you want to be able to turn off
like a TV but it should still be able to have a writeable disc for config
and stuff you download/cache etc).

> I don't doubt that if the 'power switch' method of shutdown becomes
> popular we will discover some applications that have windows where they
> can be hurt by sudden shutdown, even will full filesystem data state
> being preserved.  Such applications are arguably broken because they
> will behave badly in the event of accidental shutdown anyway, and we
> should fix them.  Well-designed applications are explicitly 'serially
> reuseable', in other words, you can interrupt at any point and start
> again from the beginning with valid and expected results.

My own opinion here is that I'm only talking about not hurting the system
if you repeatedly pull the plug.   Applications in general should cope
with death gently (in particular never destroying a saved file if they are
killed at an annoying time).


 > > --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
>

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
