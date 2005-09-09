Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbVIICrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbVIICrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbVIICrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:47:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:32985 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965245AbVIICrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:47:16 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13] x86: check host bridge when applying vendor quirks
Date: Fri, 9 Sep 2005 04:47:09 +0200
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>
References: <200509082236_MC3-1-A99D-81DD@compuserve.com>
In-Reply-To: <200509082236_MC3-1-A99D-81DD@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509090447.10118.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 04:33, Chuck Ebbert wrote:
> I was looking at the i386 ACPI early quirk code and x86_64 equivalent
> and it seems to me it should be checking the host bridge vendor, not
> the one for various PCI bridges.  Nvidia might release some kind of
> PCI card with an embedded bridge that would break this code, for
> example.  I made this patch but I can't test it:

It's wrong. On AMD K8 systems the host bridge is always from
AMD because the Northbridge is part of the CPU.

-Andi
