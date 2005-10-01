Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVJAVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVJAVPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVJAVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:15:49 -0400
Received: from smtpout6.uol.com.br ([200.221.4.197]:10701 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750848AbVJAVPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:15:48 -0400
Date: Sat, 1 Oct 2005 18:15:43 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051001211543.GB6397@ime.usp.br>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net> <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br> <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net> <Pine.LNX.4.60.0509272139220.18464@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.60.0509272139220.18464@poirot.grange>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guennadi.

On Sep 27 2005, Guennadi Liakhovetski wrote:
> Version B here. It first had only 128MB, worked fine, I added 256MB,
> system become unstable, memtest86 found "bad memory" around the last
> megabytes.

This is *quite* similar to what I am seeing.

> Then I bought 512MB, hoping to use it with 256MB - no way.

Again, similar to what I see.

> Every module alone works, but not together. But in my case memtest86
> did find errors.

This is something puzzling: when I first installed the modules to get
1.25GB, things "worked", but I had problems with memtest86+ (not
memtest86).

I changed things (removing modules), got frustrated having only 512MB on
the system with all the other modules laying around here and put them
back.

This second time, I reduced the latency on the BIOS from 2-2-2 to 3-3-3
and it booted and memtest86+ did't find any errors. Yet, I saw some
corruption, which was what prompted me to send the original mail to
linux-kernel (since I didn't know if it was a hardware or a software
problem, as memtest86+ had not found any errors).

> Try removing the 256MB module?...

Right now, I'm only using one 512MB module, but after I have already
paid for the second one, and it wasn't cheap. :-(

I suspect that the system is stable now, but I am not sure. If I
reinstall some packages with apt, it still gets some problems with the
md5sum signatures of *other* packages, which is highly weird. But I
don't see any other problems.

Puzzling, huh? I already run a SMART offline/long self-test on the disk
(to rule out it being a problem) and it passed with flying colors. I
also already used badblocks on this very disk (but in read-only mode),
and it also didn't find any problems.

I have a Quantum FIREBALLlct15 drive here.


Thanks,

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
