Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273230AbRIRJI0>; Tue, 18 Sep 2001 05:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273236AbRIRJIH>; Tue, 18 Sep 2001 05:08:07 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:11281 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273230AbRIRJHy>; Tue, 18 Sep 2001 05:07:54 -0400
Date: Tue, 18 Sep 2001 11:08:15 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Alex Stewart <alex@foogod.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
Message-ID: <20010918110815.B16592@emma1.emma.line.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Alex Stewart <alex@foogod.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010918023942.A28179@emma1.emma.line.org> <Pine.GSO.4.21.0109180453270.25323-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109180453270.25323-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Alexander Viro wrote:

> > Well, you cannot tell your local power plant "you must not fail this
> > very moment" either. Of course, data will be lost when a process is
> > killed from "D" state, but if the admin can tell the data will be lost
> > either way, ... 
> 
> Gaack... Just how do you kill a process that holds a bunch of semaphores
> and got blocked on attempt to take one more?  It's not about lost data,
> it's about completely screwed kernel.

Well, if that process holds processes and blocks getting one more,
something is wrong with the process and it's prone to deadlocks. Even if
kill -9 just means "fail this all further syscalls instantly" in such
cases, that'd be fine. Something like an "BEING KILLED" state for
processes.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
