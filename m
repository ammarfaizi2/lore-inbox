Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbQLBVN6>; Sat, 2 Dec 2000 16:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130483AbQLBVNt>; Sat, 2 Dec 2000 16:13:49 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:32564 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130392AbQLBVNn>; Sat, 2 Dec 2000 16:13:43 -0500
Message-ID: <3A295EA3.F0E47E9@linux.com>
Date: Sat, 02 Dec 2000 12:42:11 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Igmar Palsenberg <maillist@chello.nl>
CC: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>, folkert@vanheusden.com,
        "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <Pine.LNX.4.21.0012022229580.11907-100000@server.serve.me.nl>
Content-Type: multipart/mixed;
 boundary="------------D9AB2D11F856AFB5AF89EFA7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D9AB2D11F856AFB5AF89EFA7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Igmar Palsenberg wrote:

> > For a blocking fd, read(2) has always blocked until some data is
> > available.  There has never been a guarantee, for any driver, that
> > a read(2) will return the full amount of bytes requested.
>
> I know. Still leaves lot's of people that assume that reading /dev/random
> will return data, or will block.
>
> I've seen lots of programs that will assume that if we request x bytes
> from /dev/random it will return x bytes.

I find this really humorous honestly.  I see a lot of people assuming that if
you write N bytes or read N bytes that you will have done N bytes.  There are
return values for these functions that tell you clearly how many bytes were
done.

Any programmer who has evolved sufficiently from a scriptie should take
necessary precautions to check how much data was transferred.  Those who
don't..well, there is still tomorrow.

There is no reason to add any additional documentation.  If we did, we'd be
starting the trend of documenting the direction a mouse moves when it's
pushed and not to be alarmed if you turn the mouse sideways and the result is
90 degrees off.

-d


--------------D9AB2D11F856AFB5AF89EFA7
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------D9AB2D11F856AFB5AF89EFA7--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
