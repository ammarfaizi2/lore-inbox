Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVDOQur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVDOQur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVDOQur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:50:47 -0400
Received: from science.horizon.com ([192.35.100.1]:26686 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261861AbVDOQul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:50:41 -0400
Date: 15 Apr 2005 16:50:36 -0000
Message-ID: <20050415165036.16224.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: Fortuna
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, mpm@selenic.com,
       tytso@mit.edu
In-Reply-To: <20050415162225.GA23277@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the argument that "random.c doesn't rely on the strength of crypto
> primitives" is kinda lame, though I see where you're coming from.
> random.c's entropy mixing and output depends on the (endian incorrect)
> SHA-1 implementation hard coded in that file to be pre-image resistant.
> If that fails (and a few other things) then it's broken.

/dev/urandom depends on the strength of the crypto primitives.
/dev/random does not.  All it needs is a good uniform hash.

Do a bit of reading on the subject of "unicity distance".

(And as for the endianness of the SHA-1, are you trying to imply
something?  Because it makes zero difference, and reduces the code
size and execution time.  Which is obviously a Good Thing.)


As for hacking Fortuna in, could you give a clear statement of what
you're trying to achieve?

Do you like:
- The neat name,
- The strong ciphers used in the pools, or
- The multi-pool reseeding strategy, or
- Something else?

If you're doing it just for hack value, or to learn how to write a
device driver or whatever, then fine.  But if you're proposing it as
a mainline patch, then could we discuss the technical goals?

I don't think anyone wants to draw and quarter *you*, but your
code is going to get some extremely critical examination.
