Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276973AbRJDFtt>; Thu, 4 Oct 2001 01:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277092AbRJDFtl>; Thu, 4 Oct 2001 01:49:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276973AbRJDFtb>; Thu, 4 Oct 2001 01:49:31 -0400
Date: Wed, 3 Oct 2001 22:49:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <Pine.GSO.4.21.0110040142270.26177-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110032247190.7649-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Oct 2001, Alexander Viro wrote:
> <nit>
> I _really_ doubt that something does write() on /etc/passwd.  Create a
> file and rename it over the thing - sure, but that's it.
> </nit>

Well, yeah, bad choice. Can you believe /var/run/utmp or similar?

And yes, we could add checks for the thing being executable before we
accept MAP_DENYWRITE instead of just ignoring the flag from user space.
Nobody has cared enough to make the effort.

Until now?

		Linus

