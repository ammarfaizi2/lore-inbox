Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263694AbREYKzi>; Fri, 25 May 2001 06:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263695AbREYKzS>; Fri, 25 May 2001 06:55:18 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:20232 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263692AbREYKzK>; Fri, 25 May 2001 06:55:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Fri, 25 May 2001 03:03:48 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105241724430.24073-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105241724430.24073-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0105250303480T.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 May 2001 23:26, Alexander Viro wrote:
> On Thu, 24 May 2001, Edgar Toernig wrote:
> > > What *won't* happen is, you won't get side effects from opening
> > > your serial ports (you'd have to open them without O_DIRECTORY
> > > to get that) so that seems like a little step forward.
> >
> > As already said: depending on O_DIRECTORY breaks POSIX compliance
> > and that alone should kill this idea...
>
> What really kills that idea is the fact that you can trick
> applications into opening your serial ports _without_ O_DIRECTORY.

Err, I thought we already had that problem, but worse: an ordinary
ls -l will do it.  This way, we harmlessly list the device's properties 
instead.

--
Daniel

