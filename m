Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131351AbRCWTTV>; Fri, 23 Mar 2001 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRCWTTN>; Fri, 23 Mar 2001 14:19:13 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:6928 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131351AbRCWTSA>; Fri, 23 Mar 2001 14:18:00 -0500
Date: Fri, 23 Mar 2001 21:26:37 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gCYn-0003K3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103232124120.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Mar 2001, Alan Cox wrote:

> One of the things that we badly need to resurrect for 2.5 is the
> beancounter work which would let you reasonably do things like
> guaranteed Oracle a certain amount of the machine, or restrict all
> the untrusted users to a total of 200Mb hard limit between them etc

This would improve Linux reliability but it could be much better with
added *optional* non-overcommit (most other OS also support this, also
that's the default mostly [please no, "but it deadlocks" because it's
not true, they also kill processes (Solaris, etc)]), reserved superuser
memory (ala Solaris, True64, etc when OOM in non-overcommit, users
complain and superuser acts, not the OS killing their tasks) and
superuser *advisory* OOM killer [there was patch for this before], I
think in the last area Linux is already more ahead than others at
present.

About the "use resource limits!". Yes, this is one solution. The
*expensive* solution (admin time, worse resource utilization, etc).
Others make it cheaper mixing with the above ones.

        Szaka

