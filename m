Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVAGW5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVAGW5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVAGW44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:56:56 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:1555 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261684AbVAGWxR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:53:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=CUw/CosNtuwtKi9eO1kjcsi2CIY+/ZpNJq6pim31CBfhz8Ni4EGKrNGl2BkijdcbuQhDW28EXmJ1GiGKwcnZ+O3EBDzF5BZBjkx5PfRLdyVsq6BF/OwI0qxvfb5bsubrXdoeHTWm1YvJePr+cJiOEHXjzUmk2o3FlAkpfV4hOZw=
Date: Fri, 7 Jan 2005 23:53:27 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, oleg@tv-sign.ru, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
Message-Id: <20050107235327.788ee7a8.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0501071349320.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>
	<Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
	<1105113998.24187.361.camel@localhost.localdomain>
	<Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
	<Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
	<Pine.LNX.4.58.0501071349320.2272@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 7 Jan 2005 13:59:53 -0800 (PST) Linus Torvalds <torvalds@osdl.org> escribió:

> Btw, from limited testing this effect seems to be much more pronounced on
> SMP.

I've tried it in a 2xPIII, 512 MB of ram. I've done kernel compiles...yeah
yeah I know kernel compiles are not a good benchmark but since linux uses
-pipe for gcc...I though it may try it to see if it makes a difference
(suggestions about better methods to test this are accepted :). The results
could be very well stadistical noise (it looks like it only takes a second less
on average), but I though it may be interesting.


without the patch:
952.84user 98.64system 8:54.64elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7318007minor)pagefaults 0swaps
951.78user 98.25system 8:53.71elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7318009minor)pagefaults 0swaps
954.53user 99.12system 8:53.02elapsed 197%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7318041minor)pagefaults 0swaps

with it:
951.67user 97.59system 8:53.12elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7318010minor)pagefaults 0swaps
949.04user 97.68system 8:52.04elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7318018minor)pagefaults 0swaps
948.40user 97.37system 8:51.48elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7318011minor)pagefaults 0swaps
