Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129153AbQKQNja>; Fri, 17 Nov 2000 08:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129163AbQKQNjV>; Fri, 17 Nov 2000 08:39:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17414 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129153AbQKQNjM>;
	Fri, 17 Nov 2000 08:39:12 -0500
Message-ID: <3A152DC1.21B35324@mandrakesoft.com>
Date: Fri, 17 Nov 2000 08:08:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi Alan,
> 
> On Fri, 17 Nov 2000, Alan Cox wrote:
> > Even checking the cpuinfo for the TSC should be done with care, and
> > its far far better to use gettimeofday unless doing very tiny
> > timings (eg for optimising code paths)
> 
> gettimeofday is _way_ to slow for a lot of every day uses. So
> applications will use rdtsc until we have some really fast
> (non-syscall) way to have high resolution time diffs.

IIRC, this came up a long time ago WRT Apache, which made a lot of
gettimeofday() calls.  Someone (Linus?) proposed the solution of a
'magic page' which holds information like gettimeofday() stuff, but
could be handled much more rapidly than a standard syscall.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
