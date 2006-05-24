Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWEXNuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWEXNuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWEXNuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:50:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:10473 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932748AbWEXNuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:50:03 -0400
Date: Wed, 24 May 2006 15:43:38 +0200
From: Stefan Seyfried <seife@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060524134338.GB20628@suse.de>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <20060522033644.26d47a00.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060522033644.26d47a00.akpm@osdl.org>
X-Operating-System: SUSE LINUX 10.1 (i586), Kernel 2.6.16.13-4-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 03:36:44AM -0700, Andrew Morton wrote:
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> >
> > Allow taint flags to be set from userspace by writing to
> > /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> > used when userspace is potentially doing something naughty that might
> > compromise the kernel.
> 
> What sort of userspace actions are you thinking of here?

I also thought about tainting the kernel from a userspace program that
messes with runtime power management - switch off and on various devices
at runtime (which is not recommended by anyone) - and you are clearly in
Unsupportedland.

So yes, this is a good idea (although i just would have written a module
without MODULE_LICENSE that just printk'ed "Tainting kernel, we will use
runtime power management" on load.)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
