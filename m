Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWHXXQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWHXXQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWHXXQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:16:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6364 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422783AbWHXXQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:16:21 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Remove default_ldt, and simplify ldt-setting.
Date: Fri, 25 Aug 2006 01:15:36 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
References: <44EE308B.8000304@goop.org>
In-Reply-To: <44EE308B.8000304@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608250115.36879.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 01:04, Jeremy Fitzhardinge wrote:
> (This is the replacement for kill-default_ldt.patch.)
> 
> Remove default_ldt, and simplify ldt-setting.
> 
> This patch removes the default_ldt[] array, as it has been unused
> since iBCS stopped being supported.  This means it is now possible to
> actually set an empty LDT segment.
> 
> In order to deal with this, the set_ldt_desc/load_LDT pair has been
> replaced with a single set_ldt() operation which is responsible for
> both setting up the LDT descriptor in the GDT, and reloading the LDT
> register. 

Looks good.

> If there are no LDT entries, the LDT register is loaded
> with a NULL descriptor.

x86-64 currently doesn't do this -- do you see an particular advantage 
in it?

-Andi
