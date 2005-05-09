Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVEIGCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVEIGCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVEIGCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:02:17 -0400
Received: from fsmlabs.com ([168.103.115.128]:60619 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263054AbVEIGCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:02:14 -0400
Date: Mon, 9 May 2005 00:05:03 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Bruce Guenter <bruceg@em.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
In-Reply-To: <20050509035823.GA13715@em.ca>
Message-ID: <Pine.LNX.4.61.0505090002580.572@montezuma.fsmlabs.com>
References: <20050509035823.GA13715@em.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 May 2005, Bruce Guenter wrote:

> Greetings.
> 
> I am trying to diagnose a slow kernel memory leak, and am having no luck
> in pining it down.
> 
> I am currently running unpatched 2.6.12-rc3 (x86 on Gentoo, I saw the
> same symptoms with gentoo-sources 2.6.11-r6 and 2.6.11-r4.  Over the
> course of several days, the server in question has the amount of
> available memory (free minus buffers+cache) gradually decrease.  If I
> leave it go, it does eventually thrash itself to death after about a
> week (give or take).  The rate is about 150MB per day (the system has
> 2GB of RAM total so it takes several days).  The working set of
> processes remains the same through the whole period at between 50-150MB
> (depending on if you count VSZ or RSS).  Nothing shows up in dmesg
> except for a couple of one-time lockd and nfs messages  (the system uses
> two remote filesystems).  The local filesystems are ReiserFS on a 3Ware
> 7500-4 controller, and the NIC is an Intel E100.

Try looking at slabtop(1) output after a few days.
