Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbRFZPE1>; Tue, 26 Jun 2001 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264970AbRFZPEQ>; Tue, 26 Jun 2001 11:04:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25098 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264967AbRFZPEA>; Tue, 26 Jun 2001 11:04:00 -0400
Date: Tue, 26 Jun 2001 10:30:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tim Waugh <twaugh@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
In-Reply-To: <20010626102303.K7663@redhat.com>
Message-ID: <Pine.LNX.4.21.0106261027350.850-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Jun 2001, Tim Waugh wrote:

> On Tue, Jun 26, 2001 at 03:17:32AM -0300, Marcelo Tosatti wrote:
> 
> > If the initialization of parport_serial fails, we obviously get an
> > error message, which is really annoying:
> 
> [This is different to the issue that is fixed in the -ac tree about
> parport_serial getting probed for even when disabled in config.]
> 
> The idea was that people who have multi-IO cards but don't know what
> modules are can have things Just Work: parport_serial gets loaded
> automagically and detects their cards for them.  But yes, the flip
> side is that people who _don't_ have multi-IO cards are going to get
> that error.
> 
> There are three ways out, I think:
> 
> - change parport_pc so that it doesn't request parport_serial at
>   init.  In this case, how will parport_serial get loaded at all?
>   Perhaps with some recommended /etc/modules.conf lines (perhaps
>   parport_lowlevel{1,2,3,...})?

I think this is sane. This is how it works for parport_pc.


