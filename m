Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWHLNbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWHLNbp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 09:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWHLNbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 09:31:45 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:52385 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932507AbWHLNbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 09:31:44 -0400
Message-ID: <44DDD83E.9010307@comcast.net>
Date: Sat, 12 Aug 2006 09:31:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: How does Linux do RTTM?
References: <44DACA22.6090701@comcast.net>	<20060809.231244.35509467.davem@davemloft.net>	<44DAF559.8010705@comcast.net> <20060810.020205.10245646.davem@davemloft.net>
In-Reply-To: <20060810.020205.10245646.davem@davemloft.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



David Miller wrote:
> Please use netdev@vger.kernel.org for discussions about the linux
> networking implementation, not linux-kernel@vger.kernle.org
> 

Kay.

I'm told now that it uses Jiffies for TCP timestamps.  I've had thoughts
on this:

 - I figured a random timestamp with random microsecond skew would be
nice but this might expose internals of the RNG; amusingly I'm trying
not to expose internals of the RNG by exposing system time.

 - Someone recommended starting at zero.  This would work, really,
there's no attacks based on guessing the TCP timestamp value.  This is
nice since if I want to hax0rz then I might make a connection and see
how many jiffies there are to get a feel for the system's uptime; this
tells me how long since you upgraded your kernel, so I have an arsenal
of vulns I KNOW you haven't fixed ready ;)  Starting at 0 doesn't give
that information.

Comments?

> Thanks a lot.
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRN3YOws1xW0HCTEFAQKZAA//R4tRODoaWZCtEnafv7oGTJfYFjzAy06+
WzRAjOZf72cuW2xwzIMqjBzJaoXbWN/j9AgwRGzYNsjeyijVHfwVVtZHIuJUrQwd
pl4elWDDl6uFEeyWVSzBg5GLMJnB/O2Yy5E6T2TYdFaTa78T7SqwcYd5GwGj0L3I
5MxNGYMguVRr4GuYJDNefbnEIicFhrkR09O5/iqliPCWKG5613xDIKt6KWy8KIVh
n9Ui27I0MSmDuB1U1wLQiJJx01y4jAFKELdMnJk7/iyp56aBcvbohKxlqOV1nzWx
UjrPFJW4ytoWGXTxzyccHFvQZIS9oI57YnNyynCj9waaTRSc6rF4RAPLGTU77NaG
Y4leWUfEFOuvA3En0B5csFalMCPgS+hrGZF/klQIxJrKewzoK+/IWNTxixAQdUbQ
PqFE5C9U8Jt81gzVJ5ojA8BRsml48z9aj30/+4kzDJBwXjDIK4ys74orstqM+Q3U
jDgOFBww7EaS0rlw8JcVbEYStKy/gOmq6YQocCnmGGtnwrHD7owPbqo8emRhEFsE
pigFWHuuBT5liT7vAdyC2XyN8JOAFVjfda6ktDolvTAu5HV1btUmL4pxejSW82Je
+6HMedYQT2LJ4f5a29sI+UZGuyveYwITXVmgyqx8fg9Y9vEMzTdGwJzs6MHuWOoR
z7swCkgkZh0=
=J3TR
-----END PGP SIGNATURE-----
