Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276332AbRI1VzW>; Fri, 28 Sep 2001 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276330AbRI1VzM>; Fri, 28 Sep 2001 17:55:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47122 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276329AbRI1Vyz>; Fri, 28 Sep 2001 17:54:55 -0400
Date: Fri, 28 Sep 2001 14:54:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <padraig@antefacto.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: CPU frequency shifting "problems"
In-Reply-To: <8FB7D6BCE8A2D511B88C00508B68C2081971D8@orsmsx102.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0109281452330.4008-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Grover, Andrew wrote:
>
> APM is a lost cause, but the correct solution for ACPI systems is to use the
> PM timer.

This is _completely_ untrue.

The PM timer is (a) inaccurate and (b) slow as hell.

Linux uses TSC because we want high accuracy (nanosecond scale) without
having slow stuff.

But we've had other chips that were broken, and were marked as "don't use
the TSC" for real-time. They'll get worse results, but hey, if intel isn't
going to fix their TSC, that's all the more reason to buy AMD (or..)

		Linus

