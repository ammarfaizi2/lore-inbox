Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVK2QPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVK2QPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVK2QPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:15:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:15804 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751389AbVK2QPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:15:50 -0500
Date: Tue, 29 Nov 2005 17:15:48 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: Enabling RDPMC in user space by default
Message-ID: <20051129161548.GJ19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511291056.32455.raybry@mpdtxmail.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > It would be actually a good idea to disable RDTSC in ring 3 too
> > (because user space usually doesn't have enough information to make
> > good use of it and gets it wrong), but I fear that will break
> > too many applications right now.
> >
> 
> FWIW, I agree here.   We lock down the power state and still use RDTSC for 
> some timing things.

You should replace that with RDPMC 0 once I did the change IMHO.

-Andi
