Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRCGJVS>; Wed, 7 Mar 2001 04:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbRCGJVI>; Wed, 7 Mar 2001 04:21:08 -0500
Received: from smtp2.libero.it ([193.70.192.52]:16639 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S130768AbRCGJU6>;
	Wed, 7 Mar 2001 04:20:58 -0500
Message-ID: <3AA5FD4B.B2CE1AAF@alsa-project.org>
Date: Wed, 07 Mar 2001 10:20:11 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Jeremy Elson <jelson@circlemud.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <Pine.GSO.4.21.0103070409410.2127-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 7 Mar 2001, Abramo Bagnara wrote:
> 
> > Alexander Viro wrote:
> > >
> > > On Wed, 7 Mar 2001, Jeremy Elson wrote:
> > >
> > > > Right now, my code looks something like this: (it might make more
> > > > sense if you know that I've written a framework for writing user-space
> > > > device drivers... I'm going to be releasing it soon, hopefully after I
> > > > resolve this performance problem.  Or maybe before, if it's hard.)
> > >
> > > Ugh. Why not make that a named pipe and use zerocopy stuff for pipes?
> > > I.e. why bother with making it look like a character device rather than
> > > a FIFO?
> >
> > What about ioctl? Device drivers sometimes need it ;-)
> 
> No, they don't. OOB data is equivalent to data on parallel channel.

Al, you're perfectly right in principle (although last time I've checked
pipe and unix socket did not support OOB data. Is this changed
recently?).

But you're forgetting that we need to cope with non collaborative
applications (that *use* ioctl).

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
