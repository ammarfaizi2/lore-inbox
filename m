Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTCDWUr>; Tue, 4 Mar 2003 17:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTCDWUr>; Tue, 4 Mar 2003 17:20:47 -0500
Received: from [195.208.223.248] ([195.208.223.248]:10112 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261857AbTCDWUq>; Tue, 4 Mar 2003 17:20:46 -0500
Date: Wed, 5 Mar 2003 01:30:37 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Donald Becker <becker@scyld.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, jamal <hadi@cyberus.ca>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, kuznet@ms2.inr.ac.ru,
       david.knierim@tekelec.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       linux-kernel@vger.kernel.org, alexander@netintact.se
Subject: Re: PCI init issues
Message-ID: <20030305013037.A678@localhost.park.msu.ru>
References: <20030303151412.A15195@jurassic.park.msu.ru> <Pine.LNX.4.44.0303041312230.974-100000@beohost.scyld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0303041312230.974-100000@beohost.scyld.com>; from becker@scyld.com on Tue, Mar 04, 2003 at 01:16:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 01:16:22PM -0500, Donald Becker wrote:
> Incorrect.
> Most quad Tulip boards have the bus bridge wired so that all interrupts
> are sent on the INTA output of the board.

This can be true for older cards, but post-1998 hardware must follow
the spec.
PCI-to-PCI Bridge Architecture Specification, Rev 1.1, Dec 18, 1998,
pp 113-114:

 "... The interrupt binding defined in this table is mandatory for
  expansion boards utilizing a bridge.

  [table skipped]

  Device 0 on a secondary bus will have its INTA# line connected to
  the INTA# line of the connector. Device 1 will have its INTA# line
  connected to INTB# of the connector. This sequence continues and
  then wraps around once INTD# has been assigned."

I know for a fact that at least D-Link card mentioned in some reports
utilizes all four INT# lines, because I have one.

Ivan.
