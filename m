Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWHXMo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWHXMo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWHXMo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:44:26 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:60359 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751211AbWHXMoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:44:25 -0400
Date: Thu, 24 Aug 2006 09:07:41 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
Subject: Re: Linux: Why software RAID?
Message-ID: <20060824090741.J30362@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44ED1E41.40606@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
> But anyway, to help answer the question of hardware vs. software RAID, I 
> wrote up a page:
> 
> 	http://linux.yyz.us/why-software-raid.html
> 
> Generally, you want software RAID unless your PCI bus (or more rarely, 
> your CPU) is getting saturated.  With RAID-0, there is no duplication of 
> data, and so, PCI bus and CPU usage should be about the same for 
> hardware and software RAID.

Hardware RAID can be (!= is) more tolerant of serious drive failures
where a single drive locks up the bus. A high-end hardware RAID card 
may be designed with independent controllers so a single drive failure
cannot take other spindles down with it. The same can be accomplished 
with sw RAID of course if the builder is careful to use multiple PCI 
cards, etc. Sw RAID over your motherboard's onboard controllers leaves
you vulnerable.

--Adam

