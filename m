Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbTDRVAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTDRVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:00:23 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:233 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263243AbTDRVAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:00:22 -0400
Date: Fri, 18 Apr 2003 22:11:47 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: My P3 runs at.... zero Mhz (bug rpt)
Message-ID: <20030418211147.GA1225@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jurriaan <thunder7@xs4all.nl>, Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <3E9F5EAD.2070006@pobox.com> <20030418044454.GA5349@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418044454.GA5349@middle.of.nowhere>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 06:44:54AM +0200, Jurriaan wrote:
 > From: Jeff Garzik <jgarzik@pobox.com>
 > Date: Thu, Apr 17, 2003 at 10:10:53PM -0400
 > > Just booted into 2.5.67-BK-latest (plus my __builtin_memcpy patch). 
 > > Everything seems to be running just fine, so naturally one must nitpick 
 > > little things like being told my CPU is running at 0.000 Mhz.  :)
 > > 
 > fwiw, my Athlon XP2400 does the same in 2.5.67-ac1:
 > 
 > processor	: 0
 > vendor_id	: AuthenticAMD
 > cpu family	: 6
 > model		: 8
 > model name	: AMD Athlon(tm) XP 2400+
 > stepping	: 1
 > cpu MHz		: 0.000
 > cache size	: 256 KB
 > bogomips	: 1970.17


Curious. Do either of you have any cpufreq bits enabled?
If so, does it go away if you disable them?
That frobs with cpu_khz, so it *could* be not initialising
it someplace.  Especially if your hardware turns out to be
unsupported by any of the cpufreq backend drivers..

		Dave
