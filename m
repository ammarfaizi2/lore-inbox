Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTFTV7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTFTV7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:59:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56581 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264957AbTFTV7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:59:02 -0400
Date: Sat, 21 Jun 2003 00:03:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       Stephan von Krawczynski <skraw@ithnet.com>, stoffel@lucent.com,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org, willy@w.ods.org,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030620220331.GA1100@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva> <20030618130533.1f2d7205.skraw@ithnet.com> <Pine.LNX.4.55L.0306201658210.2607@freak.distro.conectiva> <3EF375BA.80901@cox.net> <Pine.LNX.4.55L.0306201812190.3808@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0306201812190.3808@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Fri, Jun 20, 2003 at 06:13:53PM -0300, Marcelo Tosatti wrote:
> > Actually, without another copy of the data on a different system to
> > verify it with, you can't know that for sure. It could easily be getting
> > to the tape (the actual media) just fine, but then get corrupted during
> > the verify readback.
> 
> Right. Stephan, if you could use a bit of your time to isolate the problem
> I would be VERY grateful.

I remember Stephan once said that he used tar to verify the tape, and that for
one backup, he did several tests showing corruption on different files. Altough
that doesn't mean that the tape is written totally correctly, it at proves that
there's at least a read corruption.

I think that comparing multiple reads to find a pattern in corruption offsets
(if any) is the only thing he could do (not speaking about mixing read/writes
with good/bad kernels). Of course, storing several times 70GB on disk is not
easy, but at least a 16 bits checksum for each 1kB block would result on about
140 MB files, which will be "easier" to compare. It could be enough to check
for empty blocks, duplicated blocks or totally random ones.

Stephan, if you're willing to do the test but don't have such a tool, I may
write a quick dirty one tomorrow if that helps.

BTW, it could be interesting to note the read buffer's hardware address for
each test, in case it matters.

Cheers,
Willy

