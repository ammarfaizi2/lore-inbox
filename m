Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWJQU6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWJQU6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWJQU6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:58:44 -0400
Received: from colin.muc.de ([193.149.48.1]:55824 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750771AbWJQU6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:58:43 -0400
Date: 17 Oct 2006 22:58:41 +0200
Date: Tue, 17 Oct 2006 22:58:41 +0200
From: Andi Kleen <ak@muc.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: [PATCH] x86_64: store Socket ID in phys_proc_id
Message-ID: <20061017205841.GA36946@muc.de>
References: <5986589C150B2F49A46483AC44C7BCA412D6F9@ssvlexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D6F9@ssvlexmb2.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 11:26:30AM -0700, Lu, Yinghai wrote:
> From: Andi Kleen [mailto:ak@muc.de] 
> 
> >> So for the apic id lifted system, for example BSP with apicid 0x10,
> the
> >> phys_proc_id will be 8.
> 
> >How is that a problem? 
> 
> Socket ID is 0 for first Physical processor?

It must just be some unique ID for each socket.

> >> It also removed ht_nodeid calculating, because We already have
> correct
> >> socket id for sure.
> 
> >we've had cases where it wasn't identical, that is when i originally
> >added that code.
> 
> OK, it must be system with Horus?

No it was with some dual core systems. Not all systems follow
the standard convention. Also there can be missing memory on
some nodes, this code handles this too.

-Andi
