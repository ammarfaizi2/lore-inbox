Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281079AbRKLWqx>; Mon, 12 Nov 2001 17:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKLWqo>; Mon, 12 Nov 2001 17:46:44 -0500
Received: from AMontpellier-201-1-5-6.abo.wanadoo.fr ([193.251.15.6]:32014
	"EHLO awak") by vger.kernel.org with ESMTP id <S281079AbRKLWqa> convert rfc822-to-8bit;
	Mon, 12 Nov 2001 17:46:30 -0500
Subject: Re: File System Performance
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E163PjZ-0007NZ-00@the-village.bc.nu>
In-Reply-To: <E163PjZ-0007NZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.1+cvs.2001.11.09.21.18 (Preview Release)
Date: 12 Nov 2001 23:39:52 +0100
Message-Id: <1005604793.17560.2.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le lun 12-11-2001 à 23:39, Alan Cox a écrit :
> >         Corrections to speed-up the sizeing pass in Amanda:
> >         * tar.h: Declare dev_null_output.
> >         * buffer.c (open_archive): Detect when archive is /dev/null.
> >         (flush_write): Avoid writing to /dev/null.
> >         * create.c (dump_file): Do not open file if archive is being
> >         written to /dev/null, nor read file nor restore times.
> >         Reported by Greg Maples and Tor Lillqvist.
> > 
> > One wonders why.
> 
> So when you archive the file set twice (once to compute its size) its
> faster. Seems sane enough. 

What would have been sane is a tar --just-compute-the-size option, not
hardcoding /dev/null.



