Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbQLOA1J>; Thu, 14 Dec 2000 19:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbQLOA06>; Thu, 14 Dec 2000 19:26:58 -0500
Received: from [199.26.153.10] ([199.26.153.10]:56074 "EHLO fourelle.com")
	by vger.kernel.org with ESMTP id <S132937AbQLOA0t>;
	Thu, 14 Dec 2000 19:26:49 -0500
Message-ID: <3A395DA8.312BC23@fourelle.com>
Date: Thu, 14 Dec 2000 15:54:16 -0800
From: Adam Scislowicz <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Non-Blocking socket (SOCK_STREAM send)
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com> <20001215002032.A24018@gruyere.muc.suse.de> <3A39573D.BB731C8@fourelle.com> <20001215003533.A26106@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From your subject you seem not to.
>
Im sorry for the subject I just wanted to give the environmental factors, and it is a
non-blocking socket. At this point I am not sure if that is relavent or not.

> To the best of my knowledge the receiver side EPIPE reporting has not changed,
> so it must be something in the sender that causes it to close the connection
> earlier. What you have to find out.
>
We simply rerun the same binary in the same environment, first with 2.2.x, and then
with 2.4.x. We have verified that socket(), and connect() calls are successfull, and
all of our problems arise when we go to send().
We do not send() until our main select() loop sets the writeable flag on our socket
descriptor, so our problem should not be related to a pre-mature send().
I dont expect this to be a kernel bug, but I was hopeing from the pseudo-code I posted
to get a "you are doing this wrong" response.
Again, everything is working in 2.2.x, but not in 2.4.x. It may be that our coding error

is only expressed in combination with the 2.4.x kernel, thats why I asked in this
mailing
list.

> No system call ever sets errno = 0.

Oh, something else in our system was doing this then. Thanx for the info.


 -Adam

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
