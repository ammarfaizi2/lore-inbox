Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDPMmh>; Mon, 16 Apr 2001 08:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRDPMm2>; Mon, 16 Apr 2001 08:42:28 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:36601 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S131424AbRDPMmK>; Mon, 16 Apr 2001 08:42:10 -0400
Date: Mon, 16 Apr 2001 14:42:03 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Pavel Machek <pavel@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010413002920.C43@(none)>
Message-Id: <Pine.LNX.4.31.0104161427400.13558-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2001, Pavel Machek wrote:

> > Then a more general user space tool could be used that would do policy
> > appropriate stuff, ending with init 0.

> init _is_ the tool which is right for defining policy on such issues.

> Take a look how UPS managment is handled.

A power failure is a different thing from a power button press. There are
users (me for example) who want to have something different then "init 0"
mapped to the power button, for example a sleep state (since my box
doesn't have a dedicated sleep button). I doubt there are many people who
want something else than a shutdown if the power is out (although I think
there will be with suspend-to-disk working, so we might have to change UPS
handling here).

My plan for power management was to have a special daemon that would
decide what to do based on system state (battery status, local time, ...)
and events (power/sleep button, last user logged out, ...) [I know that
from a programmer's POV, both are events]. This daemon could, for example,
make sure that no services are affected, for example by priming WOL and
entering a not-so-deep sleep state instead of doing a suspend-to-disk if
someone is still listening on a port after the "shutdown unimportant
services" scripts have been run.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

