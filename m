Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270646AbTGNRPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270706AbTGNRPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:15:41 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:48104 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270646AbTGNRLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:11:38 -0400
Date: Mon, 14 Jul 2003 18:26:18 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Hassard, Stephen" <SHassard@angio.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Enabling CPU freq scaling on VIA Cyrix 3 causes kernel l ockup / divide error
Message-ID: <20030714172618.GA7117@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Hassard, Stephen" <SHassard@angio.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <E2B3FD6B3FF2804CB276D9ED037268354FF620@mail4.angio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2B3FD6B3FF2804CB276D9ED037268354FF620@mail4.angio.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 08:46:19AM -0700, Hassard, Stephen wrote:
 > longhaul: VIA CPU detected. Longhaul version 2 supportred
 > longhaul: VRM 8.5 : Min VID=1.250 Max VID=1.250, 0 possible voltage scales
                           ^^^^^^^^^^^^^^^^^^^^^^^

Erk, it should default into the 'voltage scaling unavailable' mode when
this happens, but the code is missing. I'll push that out to Linus
along with a large bunch of other cpufreq changes tonight/tomorrow.

Strange how your CPU seems to claim to support voltage scaling, but
erm.. doesn't. Can you also mail me the output of x86info -a -v
(Get the snapshot from http://www.codemonkey.org.uk/cvs/ )

 > longhaul: MinMult(x10)=30 MaxMult(x10)=60
 > longhaul: Lowestspeed=0 Highestspeed=0
 > longhaul: FSB:0 Mult(x10):100

Something also went horribly wrong when trying to determine your FSB.

 > divide error: 0000 [#1]

Leading to this tradegy. I'll take a look over the longhaul code later
too, as it could use some cleanups in more than a few areas.
I've also fallen behind in adding support for the newer C3s to it.

		Dave

