Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbTCGIEy>; Fri, 7 Mar 2003 03:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCGIEy>; Fri, 7 Mar 2003 03:04:54 -0500
Received: from AGrenoble-101-1-5-159.abo.wanadoo.fr ([80.11.136.159]:54032
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S261440AbTCGIEw>; Fri, 7 Mar 2003 03:04:52 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Xavier Bestel <xavier.bestel@free.fr>
To: Ingo Molnar <mingo@elte.hu>
Cc: jvlists@ntlworld.com, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       rml@tech9.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303061925050.17038-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303061925050.17038-100000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1047024942.25382.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 07 Mar 2003 09:15:44 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 06/03/2003 à 19:27, Ingo Molnar a écrit:
> On Thu, 6 Mar 2003 jvlists@ntlworld.com wrote:
> 
> > P.S. IMVHO the xine problem is completely different as has nothing to
> > with interactivity but with the fact that it is soft real-time. i.e. you
> > need to distingish xine from say a gimp filter or a 3D renderer with
> > incremental live updates of the scene it is creating.
> 
> it is the same category of problems: xine and X are both applications,
> which, if lagged, are noticed by users.

Actually I don't think so:
- X and games need hard interactivity: they have to compute fast a
response to an input.
- xine can precompute a few frames if it wants (I dunno if it does) and
just needs a precise timing to display them and sync the audio buffers.
It could do with CPU slices if X does the right 'display this frame at
this time' thing.

	Xav

