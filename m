Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQLNX7o>; Thu, 14 Dec 2000 18:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLNX7e>; Thu, 14 Dec 2000 18:59:34 -0500
Received: from [199.26.153.10] ([199.26.153.10]:46858 "EHLO fourelle.com")
	by vger.kernel.org with ESMTP id <S129666AbQLNX7V>;
	Thu, 14 Dec 2000 18:59:21 -0500
Message-ID: <3A39573D.BB731C8@fourelle.com>
Date: Thu, 14 Dec 2000 15:26:53 -0800
From: Adam Scislowicz <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Non-Blocking socket (SOCK_STREAM send)
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com> <20001215002032.A24018@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We understand the meaning of EPIPE, the question is why 2.4.x is returning EPIPE,
while 2.2.x is succeeding in sending
the data to thttpd. Using the 2.2.x kernel our proxy functions, and I can access
thttpd directly. In 2.4.x I can access thttpd
directly but the proxy does not function.

 I have already noticed that the 2.4.x kernel does not set errno = 0 in many places
where the 2.2.x kernel did, so there are
differences.

 -Adam

Andi wrote:

> EPIPE means that the other end or you have closed the connection. It has nothing
> to do with the socket's non blockingness.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
