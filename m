Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSGPM4f>; Tue, 16 Jul 2002 08:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317846AbSGPM4e>; Tue, 16 Jul 2002 08:56:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:36612 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317845AbSGPM4d>; Tue, 16 Jul 2002 08:56:33 -0400
Date: Tue, 16 Jul 2002 09:59:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sandy Harris <pashley@storm.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch[ Simple Topology API
In-Reply-To: <m1sn2knevw.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44L.0207160955250.3009-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2002, Eric W. Biederman wrote:
> Sandy Harris <pashley@storm.ca> writes:

> >     I/O -- A ------ B ------ E ------ G -- I/O
> >            |        |        |        |
> >            |        |        |        |
> >     I/O -- C ------ D ------ F ------ H -- I/O
>
> > I suspect latency may become an issue when more than one link is
> > involved and there can be contention.
>
> I think the 8-way topology is a little more interesting than
> presented.  But if not it does look like you can run into issues.

IIRC

    I/O -- A ------ B ------ E ------ G -- I/O
           |          \    /          |
           |           \  /           |
           |            XX            |
           |           /  \           |
           |          /    \          |
    I/O -- C ------ D ------ F ------ H -- I/O

Where B is connected to F and D to E.  Obviously this
setup has a maximum hop count of 3 from any cpu to any
other cpu, as opposed to a maximum hop count of 4 for
the simple ladder.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

