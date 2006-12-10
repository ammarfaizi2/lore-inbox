Return-Path: <linux-kernel-owner+w=401wt.eu-S1758792AbWLJWOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbWLJWOr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758797AbWLJWOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:14:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40871 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758792AbWLJWOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:14:46 -0500
Date: Sun, 10 Dec 2006 14:14:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Jay Cliburn <jacliburn@bellsouth.net>, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation
 behavior
Message-Id: <20061210141435.afac089d.akpm@osdl.org>
In-Reply-To: <20061210124907.60c4a0aa.pj@sgi.com>
References: <457C64C5.9030108@bellsouth.net>
	<20061210124907.60c4a0aa.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 12:49:07 -0800
Paul Jackson <pj@sgi.com> wrote:

> Good report - thanks.
> 
> Christoph - fallback_alloc() can be called with interrupts off.
> 
> I fixed the cpuset_zone_allowed() call from fallback_alloc() to avoid
> sleeping.  Notice the __GFP_HARDWALL added in Linus's version, or the
> new function cpuset_zone_allowed_hardwall() in Andrew's version, all
> done in the last week.
> 
> But apparently kmem_getpages() can also sleep, as it calls __alloc_pages().
> 

This is lame.  Please, always always test all new submissions with all the
nice kernel debugging options enabled.

They are summarised in Documentation/SubmitChecklist, along with a number
of other useful bug-prevention suggestions.
