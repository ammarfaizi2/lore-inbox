Return-Path: <linux-kernel-owner+w=401wt.eu-S965310AbXAHKBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbXAHKBy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbXAHKBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:01:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965310AbXAHKBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:01:53 -0500
Date: Mon, 8 Jan 2007 05:01:51 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org, robbat2@gentoo.org
Subject: Re: Intel Core Duo/Duo2 T2300/E6400 - Hyper-Threading (the absence of)
Message-ID: <20070108100151.GK29911@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20070108094432.GF5276@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108094432.GF5276@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 01:44:32AM -0800, Robin H. Johnson wrote:
> (Please CC me, I am not subscribed to LKML [I have set the
> Mail-Followup-To header accordingly]).
> 
> On two of my new machines, with Intel Core Duo T2300 and Core2 Duo E6400
> chips respectively, I noticed some weirdness in how many CPUs are
> present. 
> 
> If the hyper-threading bit is present in the CPU info, should there
> always be a an extra CPU presented to the system per physical core?

No.  The ht flag just says whether HT reporting via CPUID is supported.
Core2 Duo E6400 is AFAIK not hyper-threaded, you just have 2 real sibling
CPUs (except that they share L2 cache).

	Jakub
