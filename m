Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVHDWOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVHDWOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVHDWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:14:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:64932 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262777AbVHDWNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:13:49 -0400
X-Authenticated: #1725425
Date: Fri, 5 Aug 2005 00:12:44 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-Id: <20050805001244.65f41b4f.Ballarin.Marc@gmx.de>
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
References: <200508031559.24704.kernel@kolivas.org>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005 15:59:24 +1000
Con Kolivas <kernel@kolivas.org> wrote:

> This is the dynamic ticks patch for i386 as written by Tony Lindgen 
> <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>. 
> Patch for 2.6.13-rc5

One issue (tested the -rc4 Version on -mm):
- on interrupt flood (ping -f) HZ goes down to 0-4 HZ.
  This matches "ticks to skip" below. Coincidence?

- ping -f complains:
.Warning: time of day goes back (-304us), taking countermeasures.
...
.Warning: time of day goes back (-33us), taking countermeasures.

Yet, system time _seems_ to be kept correctly.

CPU is Pentium M.

dmesg:
Using pmtmr for high-res timesource
dyn-tick: Found suitable timer: pmtmr

dyn-tick: Maximum ticks to skip limited to 54
dyn-tick: Timer not enabled during boot

sysfs:
suitable:       1
enabled:        1
using APIC:     0

Regards
