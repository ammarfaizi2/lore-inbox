Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTHRNdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTHRNdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:33:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64128 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271744AbTHRNdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:33:43 -0400
Date: Mon, 18 Aug 2003 14:33:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818133331.GA7641@mail.jlokier.co.uk>
References: <20030818004313.T3708@schatzie.adilger.int> <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com> <20030818115954.GA7147@mail.jlokier.co.uk> <yw1xzni76u84.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xzni76u84.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> >> now if you can repeatably get the same number then you probably have a bug
> >> in the random number code, but if you need uniqueness you need something
> >> else.
> >
> > Can you think of another, reliable, source of uniqueness?
> 
> You could use your geographical position and the exact time, both
> easily available with GPS.  In case several machines are within the
> GPS resolution, you could add some more parameters that would
> typically be different, such as network address.

Those are helpful inputs, but not good enough to produce a reliably
unique value.  Good randomness is better.

Your chances of a collision using the GPS coordinates, time _and_
network address together is significantly higher than a good 128-bit
random number.

This is why UUID generators typically combine some pseudo-random value
(which cannot be trusted to be properly random), and some fixed value,
such as network card MAC address, which is assumed to be unique (but
which isn't always, in practice).

Of course, public key systems don't use those parameters directly.
(They might as input entropy to a random number generator).  They can
be used to identify where you are, when you did it and who with :)

Example: MAC addresses in UUIDs are a way in which Microsoft Word
documents have revealed information about the person who wrote them :)

-- Jamie

