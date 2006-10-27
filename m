Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946386AbWJ0LAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946386AbWJ0LAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946382AbWJ0LAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:00:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:38539 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1946386AbWJ0LAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:00:24 -0400
Date: Fri, 27 Oct 2006 12:58:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux@horizon.com
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
In-Reply-To: <20061027091508.14771.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0610271250490.6761@scrub.home>
References: <20061027091508.14771.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Oct 2006, linux@horizon.com wrote:

> And given that, in the course of my experiments, I managed to reproduce
> the problem with 2.6.17+linuxpps and 2.6.19-rc3 with the ntp.c patch,
> but managed to make it go away with 2.6.19-rc3+linuxpps with the pps
> source marked "noselect" (which results in identical kernel activity,
> but doesn't actually use the returned timestamp for anything), I'm
> looking pretty hard at ntpd right now.

To analyze the kernel behaviour I would at least need the information fed 
to the kernel, e.g. by tracing the ntp daemon via "TZ=utc strace -f -tt 
-e trace=adjtimex -o ntpd.trace ..." and the ntp peer logs of same time 
period. Kernel boot messages and config might help as well.

bye, Roman
