Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278430AbRJMWlj>; Sat, 13 Oct 2001 18:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278433AbRJMWl3>; Sat, 13 Oct 2001 18:41:29 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64158 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278430AbRJMWlK>; Sat, 13 Oct 2001 18:41:10 -0400
Date: Sat, 13 Oct 2001 16:41:48 -0600
Message-Id: <200110132241.f9DMfmD28263@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <20011013214603.A1144@kushida.jlokier.co.uk>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk>
	<Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>
	<20011013214603.A1144@kushida.jlokier.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
> There are applications (GCC comes to mind) which are using mmap() to
> read files now because it is measurably faster than read(), for
> sufficiently large source files.

So? MAP_PRIVATE is just fine for these. The simple solution if you
care about an edit in the middle of a compile is to have your editor
write a new file and do an atomic rename. No half-and-half data
problems, and the VM logic is kept simple (well, relative to what we
have now;-).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
