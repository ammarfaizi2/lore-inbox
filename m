Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263553AbRFKTFS>; Mon, 11 Jun 2001 15:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263606AbRFKTFI>; Mon, 11 Jun 2001 15:05:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55058 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263553AbRFKTE5>; Mon, 11 Jun 2001 15:04:57 -0400
Date: Mon, 11 Jun 2001 16:04:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
Cc: Pavel Machek <pavel@suse.cz>, Bernd Jendrissek <berndj@prism.co.za>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106111401270.6622-100000@druid.if.uj.edu.pl>
Message-ID: <Pine.LNX.4.33.0106111603390.1742-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001, Maciej Zenczykowski wrote:
> On Fri, 8 Jun 2001, Pavel Machek wrote:
>
> > That modulo is likely slower than dereference.
> >
> > > +               if (count % 256 == 0) {
>
> You are forgetting that this case should be converted to and 255
> or a plain byte reference by any optimizing compiler

Not relevant.

What matters is that this thing calls schedule() unconditionally
every 256th time.  Checking current->need_resched will only call
schedule if it is needed ... not only that, but it will also
call schedule FASTER if it is needed.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

