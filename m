Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbQJ3S5V>; Mon, 30 Oct 2000 13:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQJ3S5M>; Mon, 30 Oct 2000 13:57:12 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47878 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129632AbQJ3S4p>;
	Mon, 30 Oct 2000 13:56:45 -0500
Message-ID: <39FDC447.C5DD7864@mandrakesoft.com>
Date: Mon, 30 Oct 2000 13:56:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com> <20001030191712.B27664@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Oct 30, 2000 at 12:19:21PM -0500, Jeff Garzik wrote:
> > Take a look at drivers/sound/via82cxxx_audio.c.  How can that mmap be
> > improved by using kiobufs?
> 
> I think so - but you need Stephen's kvmap patch, that is in the same
> patchset the forward-ported fixes are
> (at ftp://ftp.linux.org.uk/pub/linux/sct/fs/raw-io/)
> 
> An very nice example is included.

Seen it, re-read my question...

I keep seeing "audio drivers' mmap" used a specific example of a place
that would benefit from kiobufs.  The current via audio mmap looks quite
a bit like mmap_kiobuf and its support code... except without all the
kiobuf overhead.

My question from above is:  how can the via audio mmap in test10-preXX
be improved by using kiobufs?  I am not a kiobuf expert, but AFAICS a
non-kiobuf implementation is better for audio drivers.  (and the via
audio mmap implementation is what some other audio drivers are about to
start using...)

I can clearly see that many applications will find kiobufs quite useful
(learned another from alan just now...), but I do not see that audio
drivers can benefit from kiobufs at all.  Corrections on this fact are
requested, as I am hacking audio drivers right now and want to make sure
I pick the best course of action for the long term.

Regards,

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
