Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWFHMYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWFHMYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWFHMYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:24:49 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:53664 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751319AbWFHMYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:24:49 -0400
Subject: Re: [PATCH][RFC] Clean-up:  TASK_UNMAPPED_BASE and mmap_base
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44862CE3.7040406@comcast.net>
References: <44862CE3.7040406@comcast.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 14:24:47 +0200
Message-Id: <1149769487.3380.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 21:33 -0400, John Richard Moser wrote:
> This patch applies to 2.6.17-rc6 to replace several occurrences of
> TASK_UNMAPPED_BASE with current->mm->mmap_base, mm->mmap_base, or base,
> as appropriate.
> 
> I am not entirely sure what all of the code I messed with is doing, to
> be quite honest.  Code that seemed to be initializing a task and setting
> up the mmap() base I left with TASK_UNMAPPED_BASE; code that seemed to
> be trying to figure out what the mmap() base was I replaced with
> mm->mmap_base.
> 
> Because of this, I may have made a couple errors.  Could I get some
> comments on whether any of this is dirty and why?  I'll make appropriate
> changes and re-submit.  This only took 2 hours anyway.
> 

now if you put your patch inline you'd get comments in detail

but you missed that some of the places where this is used is the
fallback in case the per-task value doesnt result in a good memory hole
found.


