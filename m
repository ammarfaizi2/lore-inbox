Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbUCTRz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbUCTRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:55:56 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:41878
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263490AbUCTRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:55:53 -0500
Message-ID: <405C85A0.7010403@redhat.com>
Date: Sat, 20 Mar 2004 09:55:44 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Acker, Dave" <dacker@infiniconsys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <08628CA53C6CBA4ABAFB9E808A5214CB01EE9AD7@mercury.infiniconsys.com>
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01EE9AD7@mercury.infiniconsys.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Acker, Dave wrote:
> I can say that these other APIs are
> already being used by other programs (or other APIs themselves) and
> really can't go away.  If folks ask for ICSC support, it will probably
> get in there.

Spoken in true "proprietary-software, don't get the concept of free
software"-fashion.

Just consider the implications if this would be accepted as an argument.
 Everybody who is producing a new API has to create just a couple of
programs using it before publishing the specs to be able to say: well,
here's the API.  Use it.  Oh, and don't change it, that's not acceptable
because we have code relying on the API.  Yep, strong-arming people you
have no control over works out fine, all the time.

The only acceptable order in which things can happen is:

1. develop API

2. propose API to be accepted by "community"/distributions

3. change API if necessary, and go back to 2.

4. write applications using new API


> If folks ask for ICSC support, it will probably
> get in there.

You did not in the least address the main point: IB is just one fiber.
I cannot imagine anybody but the IB people want to have a specific API +
kernel extensions for each separate interconnect fiber.

Get it all over with in one stroke.  Come up with an API which covers it
all.  The requirements aren't that different.  And I singled out ICSC
because it attempts to do just this.

And don't say "we did our part, if the Linux community wants to have
something else it's their to come up with a unified solution".  That
would be acceptable only if it wouldn't be the IB people who want their
code to be generally accepted.  If you don't care about the later, fine,
leave it all as is.  But the code might not be picked up at all.

Furthermore, don't count on much community participation.  There aren't
many people out there with the necessary hardware.  Or even the ability
to collect experiences.  The price for the changes have to be carried by
the parties with the agenda.


> If there is
> going to be a standard linux infiniband stack it will have to be very
> good or else splinter versions and incompatible versions will live on.

And by very good you mean of course your implementation.  From the
comment above it is clear that if the standardized stack does not
include your code you intent to keep using your code anyway.  Designing
standards is always about compromises.

Nobody ever was/is happy with everything that POSIX requires.  But it is
an acceptable compromise.  One thing which has been clearly shown by
POSIX is that 99% of all developers prefer portability over getting the
last 5% of performance out of their machines.

The organizations with interconnect interest have to come together to
create just this, a compromise which in the end might not fulfill you
"very good" criteria in all places.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAXIWg2ijCOnn/RHQRAk9OAKCPAanX45/cK3zdFEN/Y28gk/vHzwCdG57w
XprZ1vZdfkT8VY3CW6T+aR0=
=gYdV
-----END PGP SIGNATURE-----
