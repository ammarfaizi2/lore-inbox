Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVEOBHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVEOBHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVEOBHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 21:07:23 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:18328 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261402AbVEOBHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 21:07:06 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
References: <1116009483.4689.803.camel@rebel.corp.whenu.com>
	<20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	<20050513215905.GY5914@waste.org>
	<1116024419.20646.41.camel@localhost.localdomain>
	<1116025212.6380.50.camel@mindpipe>
	<20050513232708.GC13846@redhat.com>
	<1116027488.6380.55.camel@mindpipe>
	<20050513234406.GG13846@redhat.com> <1116056238.7360.9.camel@mindpipe>
	<20050514153307.GA6695@g5.random>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 15 May 2005 03:07:04 +0200
In-Reply-To: <20050514153307.GA6695@g5.random>
Message-ID: <m3sm0pjo07.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> Nobody runs openssl -sign thousand of times in a row on a pure idle
> system without noticing the 100% load on the other cpu for months

Well, actually one does.  On a normal https server, each https request
results in an operation on the private key.  So if the attacker shares
the same web server as the victim it's probably rather easy for the
attacker to see when the machine is idle and launch an attack giving
him thousands of chances to spy on the victim.

But I do agree that this probably isn't all that serious, for those
who really have secrets to hide, they won't run their https server on
a machine shared with anybody else.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
