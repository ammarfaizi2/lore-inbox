Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWJWIPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWJWIPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWJWIPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:15:21 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12813 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751814AbWJWIPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:15:19 -0400
Date: Mon, 23 Oct 2006 10:15:15 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
Message-ID: <20061023081515.GQ4354@rhun.haifa.ibm.com>
References: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 12:02:44AM -0700, Yinghai Lu wrote:
> in phys flat mode, when using set_xxx_irq_affinity to irq balance from
> one cpu to another,  _assign_irq_vector will get to increase last used
> vector and get new vector. this will use up the vector if enough
> set_xxx_irq_affintiy are called. and end with using same vector in
> different cpu for different irq. (that is not what we want, we only
> want to use same vector in different cpu for different irq when more
> than 0x240 irq needed). To keep it simple, the vector should be resued
> from one cpu to another instead of getting new vector.
> 
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

Should I give this a spin? with or without Eric's two patches?

Cheers,
Muli
