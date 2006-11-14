Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754994AbWKNBvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbWKNBvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbWKNBvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:51:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:8403 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754994AbWKNBvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:51:03 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
Date: Tue, 14 Nov 2006 02:50:57 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
References: <455916A5.2030402@FreeBSD.org>
In-Reply-To: <455916A5.2030402@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140250.57160.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 02:06, Suleiman Souhlal wrote:
> I've had a proof-of-concept for this since August, and finally got around to
> somewhat cleaning it up.

Thanks. 

I got a competing implementation for this unfortunately now from Vojtech & Jiri

Yours is simpler, but I'm not sure as complete. What are your assurances
against non monoticity for example?

> 
> It can certainly still be improved, namely by using vgetcpu() instead of CPUID
> to find the cpu number (but I couldn't get it to work, when I tried).

What did not work?

> Another possible improvement would be to use RDTSCP when available.
> There's also a small race in do_gettimeofday(), vgettimeofday() and
> vmonotonic_clock() but I've never seen it happen.

I did a vposix_getclock with monotonic clock support on my own already, was about to 
be merged with the vDSO. It still used global synchronized TSC though.

-Andi 
