Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132071AbQLJSvs>; Sun, 10 Dec 2000 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132131AbQLJSvi>; Sun, 10 Dec 2000 13:51:38 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:7693 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S132130AbQLJSvd>; Sun, 10 Dec 2000 13:51:33 -0500
To: v.j.orlikowski@gte.net
Cc: Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u>
	<14898.42117.34020.145433@critterling.garfield.home>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 10 Dec 2000 18:20:31 +0000
Message-ID: <y7ru28cdtow.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Victor J. Orlikowski" <v.j.orlikowski@gte.net> writes:
> This is precisely my problem.
> K6-2, model 8, stepping 12.
> Thus far, everything is *fine*, as long as MTRR is not compiled into
> the kernel.
> If MTRR is compiled into the kernel, I get lock-ups in X *only*, and
> the entire machine locks.

Just to check the important facts (correct any of this if it is
wrong): In 2.2.18, the problem appears when you enable MTRR support,
but goes away when you disable MTRR support.  You are using the vesafb
driver.  You are running XFree86-3.x.

Are you passing any vesafb options on the kernel command line?

If not, this is very strange, because the 2.2.18 mtrr.c (or any other)
should not be touching the MTRR registers (or whatever the K6 calls
them) unless you do something to /proc/mtrr.

If I understood why the MTRR driver was doing something on the K6-2,
then model-specific differences might make some sense.  But currently,
I don't see why there would be any difference between "MTRR disabled"
and "MTRR enabled, but not used".


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
