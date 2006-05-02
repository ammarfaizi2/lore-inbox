Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWEBHrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWEBHrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWEBHrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:47:06 -0400
Received: from mail.suse.de ([195.135.220.2]:59614 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932250AbWEBHrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:47:04 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 09:46:45 +0200
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       sergio@sergiomb.no-ip.org, "Kimball Murray" <kimball.murray@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605020946.46050.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 09:41, Brown, Len wrote:

> You are right.  This code is wrong.
> It makes absolutely no sense to reserve vectors in advance
> for every RTE in the IOAPIC when we don't even know if they
> are going to be used.
> 
> This is clearly a holdover from the early IOAPIC/MPS days
> when we were talking about 4 to 8 non-legacy RTEs.

Yes I agree. A lot of the IO-APIC code could probably
need some renovation.
 
> This is where the big system vector shortage problem
> should be addressed.

If we go to per CPU IDTs it will be much less pressing, but
still a good idea.

-Andi

P.S.: There seems to be a lot of confusion about all this.
Maybe it would make sense to do a write up defining all the terms
and stick it into Documentation/* ? 
