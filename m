Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291436AbSBSOtI>; Tue, 19 Feb 2002 09:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291434AbSBSOs6>; Tue, 19 Feb 2002 09:48:58 -0500
Received: from mustard.heime.net ([194.234.65.222]:20096 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S291436AbSBSOsw>; Tue, 19 Feb 2002 09:48:52 -0500
From: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
To: "Jens Schmidt" <j.schmidt@paradise.net.nz>, linux-kernel@vger.kernel.org,
        j.schmidt@paradise.net.nz
Subject: Re: secure erasure of files?
Date: Tue, 19 Feb 2002 14:48:45 +0000
Message-ID: <20020219.HQ8.97132600@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
X-Mailer: phpGroupWare (http://www.phpgroupware.org) v 0.9.13.016
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I would strongly encourage somebody with fluent Norsk/English skills
>to do a translation and post it to the list.

I'll do my very best ...

(translated by Roy Sigurd Karlsbakk - please don't spam me in case of bad
speling :)

With permission from the leader of Research and Deveopment department, I
quote his complete answer:

I'll try to answer your questions:

The short answer is: No. It is not possible to read data that are (really)
physically overwritten.

Still, the reason to this is is a little different than what you are describing.
To speak reasonably about this, we firstly need some basic understanding of how
data is stored on a harddisk. A harddisk does not manipulate individual bits, but
flux change. Simply explained is 'flux direction' however the magnetic field points
clockwise or counter-clockwise. Thus, a 'flux change' is where the flux changes from
CCW to CW or the other way around. The mapping between flux changes is not
one-to-one.
This means that we DO NOT use CW=0, CCW=1, but rather have each flux
change
giving the origin pf 2.5 to 3 bits in addition to the disks sequence detection.
This means that it does not attempt to detect each bit isolated, but rather decodes
a sequence at a time (typically 4096 bit = 1 sector).

This sequence detection is quite the same as a human reading a bad
fax. If we try to read the fax letter by letter, we may for instance
mistake an 'a' with an 'o'. If this letter is part of the word 'bank',
and we read it letter by letter, we'll end up with 'bonk. However, if we
look at the whole word (the sequence of letters), we can probably see
the most probable word is 'bank'.

After data is overwritten, we can measure how strong the (field of the)
old data is compared to the new ones. This means that all 'old' signals
never really disappear. Still, our investigation shows that there is no
officially documented way of how to change these (old) signals back to
the origial data-

It may seem this will demand trail-breaking discoveries in many different
fields: Non-linear analysis and modelling, low-noice electronics (cryo-
electronics), computer technology (super-fast number-chrunchers)

This was the long (complicated) answer :)

What is sure: Ibas does not know any documented methods, scientific
environments or commercial services that do or demonstrate reading
of overwritten data.

--
Thor Arne Johansen
Avdelingssjef FoU, Ibas AS

Addition:

Still, it should be said that this is being argued upon between the
'wise' ones. This is - there are people that mean it is possible
to read/recover overwritten data. But we have, as mentioned above,
not found any scientific documentation or decriptions of how this
can be done.

-----------------------------------------------------------------------------
--
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.



