Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132071AbRCVQUq>; Thu, 22 Mar 2001 11:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132073AbRCVQUh>; Thu, 22 Mar 2001 11:20:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46089 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132071AbRCVQUW>; Thu, 22 Mar 2001 11:20:22 -0500
Date: Thu, 22 Mar 2001 12:01:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Guest section DW <dwguest@win.tue.nl>
Cc: "Patrick O'Rourke" <orourke@missioncriticallinux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322124727.A5115@win.tue.nl>
Message-ID: <Pine.LNX.4.21.0103221200410.21415-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Guest section DW wrote:

> > One question ... has the OOM killer ever selected init on
> > anybody's system ?
> 
> Last week I installed SuSE 7.1 somewhere.
> During the install: "VM: killing process rpm",
> leaving the installer rather confused.
> (An empty machine, 256MB, 144MB swap, I think 2.2.18.)

That's the 2.2 kernel ...


> Last month I had a computer algebra process running for a week.
> Killed. But this computation was the only task this machine had.
> Its sole reason of existence.
> Too bad - zero information out of a week's computation.
> (I think 2.4.0.)
> 
> Clearly, Linux cannot be reliable if any process can be killed
> at any moment. I am not happy at all with my recent experiences.

Note that the OOM killer in 2.4 won't kick in until your machine
is out of both memory and swap, see mm/oom_kill.c::out_of_memory().

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

