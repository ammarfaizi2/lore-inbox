Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSEAQpB>; Wed, 1 May 2002 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSEAQpA>; Wed, 1 May 2002 12:45:00 -0400
Received: from vir2.relay.fluke.com ([129.196.184.26]:34064 "EHLO
	vir2.relay.fluke.com") by vger.kernel.org with ESMTP
	id <S313293AbSEAQpA>; Wed, 1 May 2002 12:45:00 -0400
Date: Wed, 1 May 2002 09:45:01 -0700 (PDT)
From: David Dyck <dcd@tc.fluke.com>
To: Stuart MacDonald <stuartm@connecttech.com>
cc: Alan Modra <alan@linuxcare.com>, Kiyokazu SUTO <suto@ks-and-ks.ne.jp>,
        Andrew Morton <andrewm@uow.edu.au>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Kanoj Sarcar <kanoj@sgi.com>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Robert Schwebel <robert@schwebel.de>,
        Juergen Beisert <jbeisert@eurodsn.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Sapan Bhatia <sapan@corewars.org>, <linux-kernel@vger.kernel.org>
Subject: Re: changes between 2.2.20 and 2.4.x 'broke' select() from detecting
 input characters in my serial /dev/ttyS0 program
In-Reply-To: <00f501c1f121$6b7614c0$294b82ce@connecttech.com>
Message-ID: <Pine.LNX.4.33.0205010940370.3792-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 May 2002 16:49:21.0561 (UTC) FILETIME=[24775890:01C1F130]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002 at 11:03 -0400, Stuart MacDonald <stuartm@connecttech.co...:

> CREAD handling was changed to be correct; recently, but I don't know
> exactly when. The 2.4 vs 2.2 difference sounds about right though.
> Previously CREAD had been incorrectly handled by the driver and hadn't
> been changed because some apps would break. Now data is correctly
> ignored on receive when CREAD is off.
>
> When you talk about the "O_WRONLY channel" and the "O_RDONLY channel"
> you're not actually referring to separate things. Each serial port is
> represented in the kernel as one entity that may be opened different
> ways, possibly multiple times.
>
> When you turn off CREAD in your write side, you turn off CREAD for the
> whole port, including the read only side. This is not a bug in the
> driver.

Thanks for your response.  (thanks also the the other
folks that responded). It makes sense to me that 2 open calls
to the same "/dev/ttyS0" should map to the same driver and kernel
structure, so there is only one place that CREAD effects.

To bad that the 2.2 code was in error, but I can work around with that.

 David

