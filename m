Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbTDEM4r (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 07:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbTDEM4r (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 07:56:47 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6016 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262180AbTDEM4r (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 07:56:47 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200304051309.h35D9ccs000209@81-2-122-30.bradfords.org.uk>
Subject: Re: PATCH: Fixes for ide-disk.c
To: andre@linux-ide.org (Andre Hedrick)
Date: Sat, 5 Apr 2003 14:09:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10304050255540.29290-100000@master.linux-ide.org> from "Andre Hedrick" at Apr 05, 2003 02:57:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you issuing "standby" or "suspend" ?
> 
> The shutdown issues a "standby" and not a "suspend", this is why you get
> the spinup on a flush-cache.

I noticed this happening a few months ago when I was testing 2.4.20 on a
couple of similar 486 laptops.  About 25% of the time, the disk would spin
down, then up again, after the flushing IDE devices message.

I think that the argument against doing the flush first, then the standby,
was that some drives would abort, or wait on the flush, but I never saw a
conclusive answer to it.

Am I the only person who observed the spin down, and immediate spin up
behavior?

John.
