Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135874AbRDZSb6>; Thu, 26 Apr 2001 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135853AbRDZSbr>; Thu, 26 Apr 2001 14:31:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40205 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135874AbRDZSbc>; Thu, 26 Apr 2001 14:31:32 -0400
Date: Thu, 26 Apr 2001 15:31:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <200104261819.LAA03836@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0104261529480.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Adam J. Richter wrote:

> 	I have not tried it, but I would think that setting HZ to 1024
> should make a big improvement in responsiveness.
>
> 	Currently, the time slice allocated to a standard Linux
> process is 5*HZ, or 50ms when HZ is 100.  That means that you
> will notice keystrokes being echoed slowly in X when you have
> just one or two running processes,

Rubbish.  Whenever a higher-priority thread than the current
thread becomes runnable the current thread will get preempted,
regardless of whether its timeslices is over or not.

And please, DO try things before proposing a radical change
to the kernel ;)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

