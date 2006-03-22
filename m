Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWCVRFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWCVRFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWCVRFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:05:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43729 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932189AbWCVRFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:05:49 -0500
Date: Wed, 22 Mar 2006 12:05:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jes Sorensen <jes@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch -mm] notifier chain initialization
In-Reply-To: <yq0y7z2tq78.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.44L0.0603221203210.5159-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2006, Jes Sorensen wrote:

> Hi,
> 
> This one is against the -mm tree, description below.
> 
> Cheers,
> Jes
> 
> This patch goes on top of Alan Stern's
> notifier-chain-update-api-changes.patch
> 
> It restructures the notifier chain initialization macros by
> introducing FOO_NOTIFIER_INIT() macros which are used by the
> FOO_NOTIFIER_HEAD() macros.
> 
> The benefit is that one can use the FOO_NOTIFIER_INIT() macro for
> static initialization of a notifier chain.

You probably mean _dynamic_ initialization of a notifier head.  The 
current code handles static initialization just fine.

There's nothing wrong with doing things like this.  I didn't include 
initialization macros originally simply because there aren't any 
dynamically-initialized notifier heads in the kernel.

Alan Stern

