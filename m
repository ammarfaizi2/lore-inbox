Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136457AbRD3HCo>; Mon, 30 Apr 2001 03:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136462AbRD3HCg>; Mon, 30 Apr 2001 03:02:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57749 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136457AbRD3HC3>;
	Mon, 30 Apr 2001 03:02:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.3587.865614.360094@pizda.ninka.net>
Date: Mon, 30 Apr 2001 00:02:27 -0700 (PDT)
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com>
	<Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dean gaudet writes:
 > i was kind of solving a different problem with the code page though -- the
 > ability to use rdtsc on SMP boxes with processors of varying speeds and
 > synchronizations.

A better way to solve that problem is the way UltraSPARC-III do and
future ia64 systems will, by way of a "system tick" register which
increments at a constant rate regardless of how the cpus are clocked.

The "system tick" pulse goes into the processor, so it's still a local
cpu register being accessed.  Think of it as a system bus clock cycle
counter.

Granted, you probably couldn't make changes to the hardware you were
working on at the time :-)

Later,
David S. Miller
davem@redhat.com

