Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756049AbWKVRho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbWKVRho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756054AbWKVRho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:37:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:9646 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1756049AbWKVRho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:37:44 -0500
Date: Wed, 22 Nov 2006 12:37:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch -mm 2/2] driver core: Introduce device_move(): move a
 device
In-Reply-To: <20061122174530.4efa1145@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611221236090.3913-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006, Cornelia Huck wrote:

> On Wed, 22 Nov 2006 10:32:47 -0500 (EST),
> Alan Stern <stern@rowland.harvard.edu> wrote:

> > I don't see any protection against new_parent being removed while dev is
> > being transferred under it.  Are you relying on the caller to make sure
> > this never happens?
> 
> Is there any mechanism in the driver core to avoid such races? The only
> locking I can see are klists and dev->sem (which only protects
> probing). AFAICS, the caller needs to ensure consistency anyway (like
> with the subchannel mutex we introduced in s390 to ensure device
> register and unregister cannot be called concurrently).

Generally the driver core does rely on callers to handle these things.
I just wanted to make sure you were aware of the issue.

Alan Stern

