Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754806AbWKNLNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbWKNLNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbWKNLNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:13:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57283 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754806AbWKNLNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:13:00 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday() II
Date: Tue, 14 Nov 2006 12:10:43 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
References: <455916A5.2030402@FreeBSD.org> <200611140250.57160.ak@suse.de> <45592497.1080109@FreeBSD.org>
In-Reply-To: <45592497.1080109@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141210.43520.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was not able to make vgettimeofday use vgetcpu(). It seemed like vgetcpu()
> was not returning the same value as smp_processor_id() would, so the 
> values I'd get with vgettimeofday() did not completely agree with the 
> ones from gettimeofday(2). I didn't have the chance to investigate more.

I investigated now.  You got cpu hotplug disabled, right? 
The code currently only works with cpu hotplug enabled. Will fix.

-Andi
