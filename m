Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbTCPQcm>; Sun, 16 Mar 2003 11:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbTCPQcm>; Sun, 16 Mar 2003 11:32:42 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:47364 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262687AbTCPQcl>; Sun, 16 Mar 2003 11:32:41 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303161645.h2GGjZ7i000983@81-2-122-30.bradfords.org.uk>
Subject: Re: 2.4 PS/2 mouse problem
To: vojtech@suse.cz
Date: Sun, 16 Mar 2003 16:45:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303161406.h2GE6PGd000145@81-2-122-30.bradfords.org.uk> from "John Bradford" at Mar 16, 2003 02:06:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've just bought a new PS/2 mouse, and it works fine with 2.5, but in
> 2.4 it doesn't work properly if I move the mouse slowly.
> 
> I've tried 2.4.20-pre5, 2.4.20, and 2.4.19, and get the same
> problems:
> 
> In X, the mouse works fine as long as it's moved quickly, but trying
> to move it 1 pixel, for example, is almost impossible.
> 
> From the console, cat /dev/psaux displays nothing, if I move the mouse
> slowly, no matter how far it's moved.  Moving it quicky displays
> characters as expected.

OK, this was my fault :-)

In 2.5.X, psmouse_initialize is actually setting the resolution, etc,
whereas 2.4.X is just using the mouse's power on default.  Adding:

Option "Resolution" "200"

to my X config file, seems to initialise the mouse in a similar way,
and it works fine.

Never noticed this with any other PS/2 mouse, though.  Maybe this one
just has an unusual power-on default setting?

John.
