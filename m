Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUDVTu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUDVTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUDVTuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3791 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264648AbUDVTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:11 -0400
Date: Tue, 20 Apr 2004 15:03:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andi Kleen <ak@muc.de>
Cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: why change_page_attr on x86 uses __flush_tlb_all
Message-ID: <20040420130353.GC831@openzaurus.ucw.cz>
References: <1Lek1-5lB-3@gated-at.bofh.it> <m3smf5ic38.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3smf5ic38.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	I would expect __flush_tlb_one (for each page) as a better choice.
> > It'll be nice if someone can hoghlight on  why __flush_tlb_all is used.
> > The kernel version I am referring from is 2.4.18-14
> 
> This works around a bug in some early Athlons with flushing global
> large pages. Also it makes the code slightly simpler and change_page_attr
> is not really performance critical.

Perhaps comment should be added? Otherwise someone is going
to "fix" it sooner or later.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

