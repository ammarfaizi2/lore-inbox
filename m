Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJ3Vwv>; Mon, 30 Oct 2000 16:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJ3Vwm>; Mon, 30 Oct 2000 16:52:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5899 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129063AbQJ3VwZ>;
	Mon, 30 Oct 2000 16:52:25 -0500
Message-ID: <39FDED75.EE396ED3@mandrakesoft.com>
Date: Mon, 30 Oct 2000 16:51:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com> <20001030191712.B27664@caldera.de> <39FDC447.C5DD7864@mandrakesoft.com> <20001030204403.A19 <39FDD53F.5AC31232@mandrakesoft.com> <20001030213228.A4956@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Mon, Oct 30, 2000 at 03:08:31PM -0500, Jeff Garzik wrote:
> > Actually, I wonder if its even possible for mmap_kiobuf to support audio
> > -- full duplex requires that both record and playback buffer(s),
> > theoretically two separate sets of kiobufs, to be presented as one space
> > (with playback always presented before record).
> 
> kvmaps take kiovecs, which are multiple kiobufs ...

s/sets of kiobufs/kiovecs/ in my message and re-read :)

<thinks>  Ok kiobuf mmap in OSS audio is possible, but at that point
using kiobufs is still 100% overhead, because you still have to allocate
and manage DMA buffers separately due to read(2) and write(2).

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
