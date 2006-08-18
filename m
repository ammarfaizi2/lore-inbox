Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWHRJv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWHRJv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWHRJv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:51:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35491 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751332AbWHRJv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:51:57 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: PATCH: Fix crash case
References: <1155746131.24077.363.camel@localhost.localdomain>
	<Pine.LNX.4.61.0608161938320.20450@yvahk01.tjqt.qr>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2006 11:51:39 +0200
In-Reply-To: <Pine.LNX.4.61.0608161938320.20450@yvahk01.tjqt.qr>
Message-ID: <p73r6ze8j84.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> >If we are going to BUG() not panic() here then we should cover the case
> >of the BUG being compiled out
> 
> Bug can be compiled out? Ah well I much rather like this patch because of 
> the previous busy-looping, heating CPUs unnecessarily. (There was a thread, 
> about that, too.)

cpu_relax() is on most CPUs as busy as a ";". This often annoys me 
too (in particular in panic) when the CPU fans spin up and machines
become noisy. Maybe we need a portable halt() macro.

-Andi
